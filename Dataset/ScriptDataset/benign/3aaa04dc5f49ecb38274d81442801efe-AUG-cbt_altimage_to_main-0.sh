#! /bin/sh
#
# Copyright (c) 2013 The Linux Foundation. All rights reserved.
#

. /lib/functions.sh
include /lib/upgrade

kill_remaining TERM
sleep 3
kill_remaining KILL

kernel="$(find_mtd_index "kernel" | cut -d " " -f 1)"
rootfs="$(find_mtd_index "rootfs")"
alt_kernel="$(find_mtd_index "alt_kernel")"

custom_fw=$1

if [ -f $custom_fw ] && [ ! -z $custom_fw ]
then
	run_ramfs ". /lib/functions.sh; include /lib/upgrade; sync; mtd erase /dev/mtd$kernel; ubidetach /dev/ubi_ctrl -m $rootfs -f; nandwrite -m -p /dev/mtd$kernel $custom_fw; reboot"
else
	run_ramfs ". /lib/functions.sh; include /lib/upgrade; sync; mtd erase /dev/mtd$kernel; ubidetach /dev/ubi_ctrl -m $rootfs -f; nandwrite -m -p /dev/mtd$kernel /dev/mtd$alt_kernel; reboot"
fi
