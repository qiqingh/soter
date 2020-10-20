    /usr/bin/tz_setting
    log "Timezone setting is done."
    /usr/sbin/ntpd -q -p $NTP_SERVER
    remove_cron_rules
    add_cron_rules
