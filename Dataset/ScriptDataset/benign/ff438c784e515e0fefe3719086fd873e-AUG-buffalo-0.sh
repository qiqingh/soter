#!/bin/sh
# Copyright (C) 2018 OpenWrt.org
#

. /lib/functions.sh

# The mtd partition 'ubi' and 'rootfs_1' on NAND flash are os-image
# partitions. These partitions are called as "Bank1/Bank2" in U-Boot
# on WXR-2533DHP, and they are checked conditions when booting.
# Then, U-Boot checks kernel and rootfs volumes in ubi, but U-Boot
# needs "ubi_rootfs" as rootfs volume name. And, U-Boot checks the
# checksum at the end of rootfs (ubi_rootfs).
# When U-Boot writes os-image into the Bank, only kernel, rootfs
# (ubi_rootfs) and rootfs_data (ubi_rootfs_data) volumes are wrote
# into the Bank. (not full ubi image)
#
# == U-Boot Behaviors ==
# - Bank1/Bank2 images are good, images are different
#   -> writes os-image to Bank1 from Bank2
#      (this behavior is used to firmware upgrade in stock firmware)
# - Bank1 image is broken (or checksum error)
#   -> writes os-image to Bank1 from Bank2
# - Bank2 image is broken (or checksum error)
#   -> writes os-image to Bank2 from Bank1
# - Bank1/Bank2 images are broken (or checksum error)
#   -> start tftp

