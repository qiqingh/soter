#
# Copyright (C) 2010 OpenWrt.org
#

. /lib/ramips.sh

PART_NAME=firmware
RAMFS_COPY_DATA=/lib/ramips.sh

append sysupgrade_pre_upgrade disable_watchdog
append sysupgrade_pre_upgrade blink_led
