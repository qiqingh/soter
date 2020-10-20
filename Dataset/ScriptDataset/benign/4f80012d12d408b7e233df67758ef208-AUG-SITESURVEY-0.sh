#!/bin/sh
xmldbc -s /runtime/wifi_tmpnode/state DOING
iwlist wlan0 scanning > /var/ssvy.txt
iwlist wlan1 scanning >> /var/ssvy.txt
Parse2DB sitesurvey -f /var/ssvy.txt -d > /dev/null
rm /var/ssvy.txt
exit 0
