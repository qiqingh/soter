#! /bin/sh

. /lib/functions.sh
include /lib/upgrade

custom_fw=$1
custom_md5sum=$2

u_env="$(find_mtd_index "u_env")"
s_env="$(find_mtd_index "s_env")"
syscfg="$(find_mtd_index "syscfg")"
alt_kernel="$(find_mtd_index "alt_kernel")"

cd /tmp/

	if [ ! -s /tmp/$custom_fw ] || [ ! -f /tmp/$custom_fw ]
	then
		echo "Firmware not found!!!"
	else
		if [ ! -z $custom_md5sum ]
		then
			compute_checksum=`md5sum /tmp/$custom_fw | cut -d " " -f 1`
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
		/usr/sbin/nandwrite -m -p /dev/mtd$alt_kernel /tmp/$custom_fw
		/sbin/cbt_altimage_to_main.sh /tmp/$custom_fw
	fi
