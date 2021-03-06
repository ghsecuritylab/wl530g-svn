
/*
 * $Id: pconn.c,v 1.25.4.1 2000/02/09 23:29:59 wessels Exp $
 *
 * DEBUG: section 48    Persistent Connections
 * AUTHOR: Duane Wessels
 *
 * SQUID Internet Object Cache  http://squid.nlanr.net/Squid/
 * ----------------------------------------------------------
 *
 *  Squid is the result of efforts by numerous individuals from the
 *  Internet community.  Development is led by Duane Wessels of the
 *  National Laboratory for Applied Network Research and funded by the
 *  National Science Foundation.  Squid is Copyrighted (C) 1998 by
 *  the Regents of the University of California.  Please see the
 *  COPYRIGHT file for full details.  Squid incorporates software
 *  developed and/or copyrighted by other sources.  Please see the
 *  CREDITS file for full details.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.
 *
 */

#include "squid.h"

struct _pconn {
    char *key;
    struct _pconn *next;
    int *fds;
    int nfds_alloc;
    int nfds;
};

#define PCONN_HIST_SZ (1<<16)
int client_pconn_hist[PCONN_HIST_SZ];
int server_pconn_hist[PCONN_HIST_SZ];

static PF pconnRead;
static PF pconnTimeout;
static const char *pconnKey(const char *host, u_short port);
static hash_table *table = NULL;
static struct _pconn *pconnNew(const char *key);
static void pconnDelete(struct _pconn *p);
static void pconnRemoveFD(struct _pconn *p, int fd);
static OBJH pconnHistDump;

static const char *
pconnKey(const char *host, u_short port)
{
    LOCAL_ARRAY(char, buf, SQUIDHOSTNAMELEN + 10);
    snprintf(buf, SQUIDHOSTNAMELEN + 10, "%s.%d", host, (int) port);
    return buf;
}

static struct _pconn *
pconnNew(const char *key)
{
    struct _pconn *p = xcalloc(1, sizeof(struct _pconn));
    p->key = xstrdup(key);
    p->nfds_alloc = 2;
    p->fds = xcalloc(p->nfds_alloc, sizeof(int));
    debug(48, 3) ("pconnNew: adding %s\n", p->key);
    hash_join(table, (hash_link *) p);
    return p;
}

static void
pconnDelete(struct _pconn *p)
{
    debug(48, 3) ("pconnDelete: deleting %s\n", p->key);
    hash_remove_link(table, (hash_link *) p);
    xfree(p->fds);
    xfree(p->key);
    xfree(p);
}

static void
pconnRemoveFD(struct _pconn *p, int fd)
{
    int i;
    for (i = 0; i < p->nfds; i++) {
	if (p->fds[i] == fd)
	    break;
    }
    assert(i < p->nfds);
    debug(48, 3) ("pconnRemoveFD: found FD %d at index %d\n", fd, i);
    for (; i < p->nfds - 1; i++)
	p->fds[i] = p->fds[i + 1];
    if (--p->nfds == 0)
	pconnDelete(p);
}

static void
pconnTimeout(int fd, void *data)
{
    struct _pconn *p = data;
    assert(table != NULL);
    debug(48, 3) ("pconnTimeout: FD %d %s\n", fd, p->key);
    pconnRemoveFD(p, fd);
    comm_close(fd);
}

static void
pconnRead(int fd, void *data)
{
    LOCAL_ARRAY(char, buf, 256);
    struct _pconn *p = data;
    int n;
    assert(table != NULL);
    Counter.syscalls.sock.reads++;
    n = read(fd, buf, 256);
    debug(48, 3) ("pconnRead: %d bytes from FD %d, %s\n", n, fd, p->key);
    pconnRemoveFD(p, fd);
    comm_close(fd);
}

static void
pconnHistDump(StoreEntry * e)
{
    int i;
    storeAppendPrintf(e,
	"Client-side persistent connection counts:\n"
	"\n"
	"\treq/\n"
	"\tconn      count\n"
	"\t----  ---------\n");
    for (i = 0; i < PCONN_HIST_SZ; i++) {
	if (client_pconn_hist[i] == 0)
	    continue;
	storeAppendPrintf(e, "\t%4d  %9d\n", i, client_pconn_hist[i]);
    }
    storeAppendPrintf(e,
	"\n"
	"Server-side persistent connection counts:\n"
	"\n"
	"\treq/\n"
	"\tconn      count\n"
	"\t----  ---------\n");
    for (i = 0; i < PCONN_HIST_SZ; i++) {
	if (server_pconn_hist[i] == 0)
	    continue;
	storeAppendPrintf(e, "\t%4d  %9d\n", i, server_pconn_hist[i]);
    }
}

/* ========== PUBLIC FUNCTIONS ============================================ */


void
pconnInit(void)
{
    int i;
    assert(table == NULL);
    table = hash_create((HASHCMP *) strcmp, 229, hash_string);
    for (i = 0; i < PCONN_HIST_SZ; i++) {
	client_pconn_hist[i] = 0;
	server_pconn_hist[i] = 0;
    }
    cachemgrRegister("pconn",
	"Persistent Connection Utilization Histograms",
	pconnHistDump, 0, 1);
    debug(48, 3) ("persistent connection module initialized\n");
}

void
pconnPush(int fd, const char *host, u_short port)
{
    struct _pconn *p;
    int *old;
    LOCAL_ARRAY(char, key, SQUIDHOSTNAMELEN + 10);
    LOCAL_ARRAY(char, desc, FD_DESC_SZ);
    if (fdNFree() < (RESERVED_FD << 1)) {
	debug(48, 3) ("pconnPush: Not many unused FDs\n");
	comm_close(fd);
	return;
    } else if (shutting_down) {
	comm_close(fd);
	return;
    }
    assert(table != NULL);
    strcpy(key, pconnKey(host, port));
    p = (struct _pconn *) hash_lookup(table, key);
    if (p == NULL)
	p = pconnNew(key);
    if (p->nfds == p->nfds_alloc) {
	debug(48, 3) ("pconnPush: growing FD array\n");
	p->nfds_alloc <<= 1;
	old = p->fds;
	p->fds = xmalloc(p->nfds_alloc * sizeof(int));
	xmemcpy(p->fds, old, p->nfds * sizeof(int));
	xfree(old);
    }
    p->fds[p->nfds++] = fd;
    commSetSelect(fd, COMM_SELECT_READ, pconnRead, p, 0);
    commSetTimeout(fd, Config.Timeout.pconn, pconnTimeout, p);
    snprintf(desc, FD_DESC_SZ, "%s idle connection", host);
    fd_note(fd, desc);
    debug(48, 3) ("pconnPush: pushed FD %d for %s\n", fd, key);
}

int
pconnPop(const char *host, u_short port)
{
    struct _pconn *p;
    hash_link *hptr;
    int fd = -1;
    LOCAL_ARRAY(char, key, SQUIDHOSTNAMELEN + 10);
    assert(table != NULL);
    strcpy(key, pconnKey(host, port));
    hptr = hash_lookup(table, key);
    if (hptr != NULL) {
	p = (struct _pconn *) hptr;
	assert(p->nfds > 0);
	fd = p->fds[0];
	pconnRemoveFD(p, fd);
	commSetSelect(fd, COMM_SELECT_READ, NULL, NULL, 0);
	commSetTimeout(fd, -1, NULL, NULL);
    }
    return fd;
}

void
pconnHistCount(int what, int i)
{
    if (i >= PCONN_HIST_SZ)
	i = PCONN_HIST_SZ - 1;
    /* what == 0 for client, 1 for server */
    if (what == 0)
	client_pconn_hist[i]++;
    else if (what == 1)
	server_pconn_hist[i]++;
    else
	assert(0);
}
