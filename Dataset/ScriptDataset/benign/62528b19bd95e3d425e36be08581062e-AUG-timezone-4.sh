    uci set system.ntp.enabled='0'
    uci commit system
    remove_cron_rules
