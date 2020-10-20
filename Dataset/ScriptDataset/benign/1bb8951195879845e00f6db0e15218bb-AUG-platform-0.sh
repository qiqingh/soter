PART_NAME=firmware

CI_BLKSZ=65536

# CONFIG_WATCHDOG_NOWAYOUT=y - can't kill watchdog unless kernel cmdline has a mpcore_wdt.nowayout=0
#append sysupgrade_pre_upgrade disable_watchdog
