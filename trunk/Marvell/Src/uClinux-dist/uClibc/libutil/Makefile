# Makefile for uClibc
#
# Copyright (C) 2000 by Lineo, inc.
# Copyright (C) 2000-2002 Erik Andersen <andersen@uclibc.org>
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU Library General Public License as published by the Free
# Software Foundation; either version 2 of the License, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Library General Public License for more
# details.
#
# You should have received a copy of the GNU Library General Public License
# along with this program; if not, write to the Free Software Foundation, Inc.,
# 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#
# Derived in part from the Linux-8086 C library, the GNU C Library, and several
# other sundry sources.  Files within this library are copyright by their
# respective copyright holders.

TOPDIR=../
include $(TOPDIR)Rules.mak
LIBC=$(TOPDIR)libc.a

LIBUTIL=libutil.a
LIBUTIL_SHARED=libutil.so
LIBUTIL_SHARED_FULLNAME=libutil-$(MAJOR_VERSION).$(MINOR_VERSION).$(SUBLEVEL).so

CSRC=login.c login_tty.c logout.c logwtmp.c openpty.c
ifeq ($(strip $(UCLIBC_HAS_MMU)),y)
    CSRC+=forkpty.c
endif
OBJS=$(patsubst %.c,%.o, $(CSRC))

all: $(OBJS) $(LIBC)

$(LIBC): ar-target

ar-target: $(OBJS)
	$(AR) $(ARFLAGS) $(LIBUTIL) $(OBJS)
	install -d $(TOPDIR)lib
	rm -f $(TOPDIR)lib/$(LIBUTIL)
	install -m 644 $(LIBUTIL) $(TOPDIR)lib/

$(OBJS): %.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@
	$(STRIPTOOL) -x -R .note -R .comment $*.o

shared: all
	$(LD) $(LDFLAGS) -soname=$(LIBUTIL_SHARED).$(MAJOR_VERSION) \
		-o $(LIBUTIL_SHARED_FULLNAME) --whole-archive $(LIBUTIL) \
		--no-whole-archive $(TOPDIR)/libc/misc/internals/interp.o \
		-L$(TOPDIR)/lib -lc;
	install -d $(TOPDIR)lib
	rm -f $(TOPDIR)lib/$(LIBUTIL_SHARED_FULLNAME) $(TOPDIR)lib/$(LIBUTIL_SHARED).$(MAJOR_VERSION)
	install -m 644 $(LIBUTIL_SHARED_FULLNAME) $(TOPDIR)lib/;
	(cd $(TOPDIR)lib && ln -sf $(LIBUTIL_SHARED_FULLNAME) $(LIBUTIL_SHARED)); 
	(cd $(TOPDIR)lib && ln -sf $(LIBUTIL_SHARED_FULLNAME) $(LIBUTIL_SHARED).$(MAJOR_VERSION)); 

clean:
	rm -f *.[oa] *~ core $(LIBUTIL_SHARED)* $(LIBUTIL_SHARED_FULLNAME)*

