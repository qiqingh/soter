#! /bin/sh

. /lib/functions.sh
include /lib/upgrade

serverip=192.168.1.254
custom_fw=$1
custom_md5sum=$2

u_env="$(find_mtd_index "u_env")"
s_env="$(find_mtd_index "s_env")"
syscfg="$(find_mtd_index "syscfg")"
alt_kernel="$(find_mtd_index "alt_kernel")"

cd /tmp/
echo "tftp $serverip -g -r $custom_fw"
echo "......"
tftp $serverip -g -r $custom_fw
if [ $? -ne 0 ]
then
	echo "tftp failed, please check your network..."
else
	if [ ! -s ./$custom_fw ] || [ ! -f ./$custom_fw ]
	then
		echo "Firmware not found!!!"
	else
		echo "tftp-hpa completed!!!"

		if [ ! -z $custom_md5sum ]
		then
			compute_checksum=`md5sum $custom_fw | cut -d " " -f 1`
			if [ $compute_checksum != $custom_md5sum ]
			then
				echo "checksum error!!!"
				return 0
			else
				echo "checksum $compute_checksum correct!!!"
			fi
		fi

		echo "reset boot-env to factory default"
		mtd erase /dev/mtd$u_env
		mtd erase /dev/mtd$s_env
		mtd erase /dev/mtd$syscfg

		mtd erase /dev/mtd$alt_kernel
		#dd if=$custom_fw of=/dev/mtd15 bs=2048 conv=sync
		#/sbin/cbt_altimage_to_main.sh
		/usr/sbin/nandwrite -m -p /dev/mtd$alt_kernel /tmp/$custom_fw
		/sbin/cbt_altimage_to_main.sh /tmp/$custom_fw
	fi
fi
