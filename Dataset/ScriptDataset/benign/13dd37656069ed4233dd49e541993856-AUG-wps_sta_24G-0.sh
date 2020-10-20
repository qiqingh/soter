#!/bin/sh
echo [$0] ["$1"] [$2] [$3] [$4] ["$5"]> /dev/console
#phpsh /etc/scripts/wps/wps.php PARAM1=save PARAM2=STA BAND=24G SSID="$1" AUTHMODE=$2 ENCRTYPE=$3 KEYINDEX=$4 KEYSTR="$5"
xmldbc -P /etc/scripts/wps/wps.php -V PARAM1=save -V PARAM2=STA -V BAND=24G -V SSID="$1" -V AUTHMODE=$2 -V ENCRTYPE=$3 -V KEYINDEX=$4 -V KEYSTR="$5" -V UUID=$6 -V EVENTTYPE=$7 > /var/run/wps_sta_24G.sh
sh /var/run/wps_sta_24G.sh
rm /var/run/wps_sta_24G.sh
exit 0 
