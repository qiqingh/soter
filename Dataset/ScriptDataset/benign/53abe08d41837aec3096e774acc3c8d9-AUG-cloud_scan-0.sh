#!/bin/sh
echo [$0] ... > /dev/console
rm /tmp/cloud/cloud_scan
iwlist ath0 scanning
wlanconfig ath0 list scan
rgdb -A /etc/templates/cloud_scan.php > /var/run/cloud_scan.sh
sh /var/run/cloud_scan.sh
