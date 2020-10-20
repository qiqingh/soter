# Copyright (C) 2011 OpenWrt.org

PART_NAME=firmware

REQUIRE_IMAGE_METADATA=1
RAMFS_COPY_BIN='fw_printenv fw_setenv nandwrite'
RAMFS_COPY_DATA='/etc/fw_env.config /var/lock/fw_printenv.lock'

