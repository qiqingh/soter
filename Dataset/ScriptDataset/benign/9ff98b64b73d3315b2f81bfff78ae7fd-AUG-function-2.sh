#Linux2.6 uses udev instead of devfs, we have to create static dev node by myself.
if [ "$CONFIG_HOTPLUG" == "y" -a "$CONFIG_USB" == "y" -o "$CONFIG_MMC" == "y" ]; then
	mounted=`mount | grep mdev | wc -l`
	if [ $mounted -eq 0 ]; then
#	mount -t ramfs none /dev
	mount -t ramfs mdev /dev
	mkdir /dev/pts
	mount -t devpts devpts /dev/pts

        mknod   /dev/video0      c       81      0
	mknod	/dev/ppp	 c	 108	 0   
        mknod   /dev/spiS0       c       217     0
        mknod   /dev/i2cM0       c       218     0
        mknod   /dev/mt6605      c       219     0
        mknod   /dev/flash0      c       200     0
        mknod   /dev/swnat0      c       210     0
        mknod   /dev/hwnat0      c       220     0
        mknod   /dev/acl0        c       230     0
        mknod   /dev/ac0         c       240     0
        mknod   /dev/mtr0        c       250     0
        mknod   /dev/apsoc_nvram       c       251     0      
        if [ "$CONFIG_ARCH_MT7623" = "y" ]; then
        	mknod   /dev/rdm0        c       263     0
        	mknod   /dev/gpio        c       241     0
        else
        	mknod   /dev/rdm0        c       253     0
          mknod   /dev/gpio        c       252     0  
        fi
        mknod   /dev/pcm0        c       233     0
        mknod   /dev/i2s0        c       191     0
        mknod   /dev/cls0        c       235     0
	mknod   /dev/spdif0      c       236     0
	mknod   /dev/vdsp        c       245     0
	mknod   /dev/slic        c       225     0
if [ "$CONFIG_SOUND" = "y" ] || [ "$CONFIG_SOUND" = "m" ]; then
	mknod   /dev/controlC0   c       116     0
	mknod   /dev/pcmC0D0c    c       116     24
	mknod   /dev/pcmC0D0p    c       116     16
fi	

	fi
	echo "# <device regex> <uid>:<gid> <octal permissions> [<@|$|*> <command>]" > /etc/mdev.conf
        echo "# The special characters have the meaning:" >> /etc/mdev.conf
        echo "# @ Run after creating the device." >> /etc/mdev.conf
        echo "# $ Run before removing the device." >> /etc/mdev.conf
        echo "# * Run both after creating and before removing the device." >> /etc/mdev.conf
        echo "sd[a-z][1-9] 0:0 0660 */sbin/automount_boot.sh \$MDEV" >> /etc/mdev.conf
        echo "sd[a-z] 0:0 0660 */sbin/automount_boot.sh \$MDEV" >> /etc/mdev.conf
	echo "mmcblk[0-9]p[0-9] 0:0 0660 */sbin/automount_boot.sh \$MDEV" >> /etc/mdev.conf
	echo "mmcblk[0-9] 0:0 0660 */sbin/automount_boot.sh \$MDEV" >> /etc/mdev.conf
	if [ "$CONFIG_USB_SERIAL" = "y" ] || [ "$CONFIG_USB_SERIAL" = "m" ]; then
		echo "ttyUSB0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi
	if [ "$CONFIG_BLK_DEV_SR" = "y" ] || [ "$CONFIG_BLK_DEV_SR" = "m" ]; then
		echo "sr0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi
	if [ "$CONFIG_USB_SERIAL_HSO" = "y" ] || [ "$CONFIG_USB_SERIAL_HSO" = "m" ]; then
		echo "ttyHS0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi
fi
