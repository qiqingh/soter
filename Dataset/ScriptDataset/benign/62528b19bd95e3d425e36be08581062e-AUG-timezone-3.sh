    echo "0 12 * * * /usr/sbin/ntpd -q -p $NTP_SERVER #ntp" >> $CRONTAB_ROOT
    echo "0 0 * * * /usr/sbin/ntpd -q -p $NTP_SERVER #ntp" >> $CRONTAB_ROOT
