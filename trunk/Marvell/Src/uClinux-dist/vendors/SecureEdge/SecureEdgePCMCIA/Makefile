#
#	Makefile -- Build instructions for SecureEdge/SecureEdgePCMCIA
#

include $(LINUX_CONFIG)
include $(CONFIG_CONFIG)
include $(ARCH_CONFIG)

ROMFS_DIRS = dev/usb
USB_DEVICES = dabusb0,180,240
EXTRA_DEVICES = video,c,81,0 video0,c,81,0 video1,c,81,1 \
		cardpro0,c,125,0 cardpro1,c,125,1

all clean image:
	$(MAKE) -C ../SecureEdge2580 $@

romfs:
	$(MAKE) -C ../SecureEdge2580 $@
	for i in $(ROMFS_DIRS); do \
		mkdir -p $(ROMFSDIR)/$$i; \
	done
	for i in $(USB_DEVICES); do \
		touch $(ROMFSDIR)/dev/usb/@$$i; \
	done
	for i in $(EXTRA_DEVICES); do \
		touch $(ROMFSDIR)/dev/@$$i; \
	done
	$(ROMFSINST) /etc/inittab
	$(ROMFSINST) /etc/rc
	$(ROMFSINST) /etc/fstab
	echo "/etc/rc.d/rc.pcmcia start" >> $(ROMFSDIR)/etc/default/start
	echo "insmod usbcore" >> $(ROMFSDIR)/etc/default/start
	echo "insmod usb-ohci" >> $(ROMFSDIR)/etc/default/start
	echo "mount -t usbdevfs none /proc/bus/usb" >> $(ROMFSDIR)/etc/default/start
	#echo "insmod sarlib" >> $(ROMFSDIR)/etc/default/start
	#echo "insmod speedtch" >> $(ROMFSDIR)/etc/default/start
	#echo "insmod videodev" >> $(ROMFSDIR)/etc/default/start
	#echo "insmod ov511" >> $(ROMFSDIR)/etc/default/start

