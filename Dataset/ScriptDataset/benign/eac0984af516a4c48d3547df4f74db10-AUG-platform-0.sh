#
# Copyright (C) 2014-2016 OpenWrt.org
# Copyright (C) 2016 LEDE-Project.org
#

. /lib/mvebu.sh

RAMFS_COPY_DATA=/lib/mvebu.sh
REQUIRE_IMAGE_METADATA=1

append sysupgrade_pre_upgrade disable_watchdog
