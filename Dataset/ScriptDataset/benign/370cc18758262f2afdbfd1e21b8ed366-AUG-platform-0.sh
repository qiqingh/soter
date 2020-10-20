. /lib/ixp4xx.sh

RAMFS_COPY_DATA="/lib/ixp4xx.sh"

CI_BLKSZ=65536
CI_LDADR=0x00800000

# CONFIG_WATCHDOG_NOWAYOUT=y - can't kill watchdog unless kernel cmdline has a mpcore_wdt.nowayout=0
#append sysupgrade_pre_upgrade disable_watchdog
