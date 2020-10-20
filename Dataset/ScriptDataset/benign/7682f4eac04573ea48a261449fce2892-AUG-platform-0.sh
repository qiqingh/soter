#
# Copyright (C) 2011 OpenWrt.org
#

. /lib/functions/system.sh
. /lib/ar71xx.sh

PART_NAME=firmware
RAMFS_COPY_DATA=/lib/ar71xx.sh

CI_BLKSZ=65536
CI_LDADR=0x80060000

append sysupgrade_pre_upgrade disable_watchdog
