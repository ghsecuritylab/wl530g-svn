#
# Router rc control scripts Makefile
#
# Copyright 2003, Broadcom Corporation
# All Rights Reserved.                
#                                     
# This is UNPUBLISHED PROPRIETARY SOURCE CODE of Broadcom Corporation;   
# the contents of this file may not be disclosed to third parties, copied
# or duplicated in any form, in whole or in part, without the prior      
# written permission of Broadcom Corporation.                            
#
# $Id: Makefile,v 1.30 2003/06/02 23:59:08 mhuang Exp $
#

#include $(TOP)/.config
CC=arm-elf-gcc

CFLAGS += -I. -I../shared/include 
CFLAGS += -I../../user/ffnetdrv/include -I../../user/ffnetdrv/qd_drv/include -I../ffnetdrv/unimac
all: $(EXEC)
CFLAGS	+= -s -O2  

#################################
# other defines:
# DEBUG
# INCLUDE_INFOSVR

INSTALLDIR = ../../../../../firmware_files/rootfs
#LDFLAGS	+= -L$(TOP)/nvram -L$(INSTALLDIR)/nvram/usr/lib -lnvram -L$(TOP)/shared -L$(INSTALLDIR)/shared/usr/lib -lshared 
LDFLAGS = -lcrypt -Wl,-elf2flt="-s 64000" 

# Add for ASUS modification
CFLAGS 	+= -DASUS_EXT -DASUS -DASUS_EXTENSION -DWPA2 -DWDS -DNOMPPE -DRPPPPOE -DREMOVE_USB -DREMOVE_WEBCAM
OBJS := rc.o init.o interface.o network.o services.o udhcpc.o ppp.o http.o stats.o crc.o ext_asus.o firewall.o ../shared/shutils.o utils.o nvram_x.o nvram_f.o mtdutil.o mtd.o defaults.o ../shared/nvram_linux.o ../shared/nvparse.o ../netconf/netconf_linux.o services_ex.o common_ex.o network_ex.o manu_ex.o firewall_ex.o watchdog.o ntp.o udhcpc_ex.o http_ex.o rgcfg.o bigpond.o

ifeq ($(CONFIG_NETCONF),y)
OBJS += firewall.o
LDFLAGS += -L$(TOP)/netconf -L$(INSTALLDIR)/netconf/usr/lib -lnetconf 
endif


vpath %.c $(TOP)/shared $(SRCBASE)/rts/src

all: rc

clean:
	rm -f *.o rc

install: all
	install -d $(INSTALLDIR)/sbin
	install rc $(INSTALLDIR)/sbin
	#$(STRIP) $(INSTALLDIR)/sbin/rc
	cd $(INSTALLDIR)/sbin && ln -sf rc init
	cd $(INSTALLDIR)/sbin && ln -sf rc erase
	cd $(INSTALLDIR)/sbin && ln -sf rc write
	# todo: check stats
	cd $(INSTALLDIR)/sbin && ln -sf rc stats
	cd $(INSTALLDIR)/sbin && ln -sf rc stopservice
	cd $(INSTALLDIR)/sbin && ln -sf rc rgcfg
	#cd $(INSTALLDIR)/sbin && ln -sf rc hotplug
	#cd $(INSTALLDIR)/sbin && ln -sf rc nslookup

rc: $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS) ../iptables/libiptc/libiptc.a

