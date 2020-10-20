#
# Copyright (C) 2011 OpenWrt.org
#

. /lib/mpc85xx.sh

PART_NAME=firmware
RAMFS_COPY_DATA=/lib/mpc85xx.sh

append sysupgrade_pre_upgrade disable_watchdog
