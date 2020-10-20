#!/bin/sh

username_old=`nvram_get 2860 ddns_username`
username="${username_old//\@/%40}"
ddnspass=`nvram_get 2860 ddns_passwd`
hostname=`nvram_get 2860 ddns_hostname`
EFFECTIVE_WAN_IPADDR=`nvram_get 2860 wan_ipaddr`
MODEL=`nvram_get 2860 model_name`

EFFECTIVE_WAN_IPADDR_b1=`nvram_get 2860 wan_ipaddr_noip_b1`
now_status=`nvram_get 2860 ddns_recode`
username_b1=`nvram_get 2860 ddns_username_noip_b1`
ddnspass_b1=`nvram_get 2860 ddns_passwd_noip_b1`
hostname_b1=`nvram_get 2860 ddns_hostname_noip_b1`

update_noip_server ()
if [ "$now_status" == "good" ] || [ "$now_status" == "nochg" ]; then
		if [ "$EFFECTIVE_WAN_IPADDR_b1" != "$EFFECTIVE_WAN_IPADDR" ]; then
			update_noip_server
		elif [ "$username_b1" != "$username_old" ] || [ "$ddnspass_b1" != "$ddnspass" ] || [ "$hostname_b1" != "$hostname" ]; then
			update_noip_server
		fi
else
	update_noip_server
fi

