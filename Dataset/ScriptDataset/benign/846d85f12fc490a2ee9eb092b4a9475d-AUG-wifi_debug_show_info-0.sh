#!/bin/sh
source /etc/init.d/syscfg_api.sh
STA_ENABLED=`syscfg get wifi_bridge::mode`
if [ "1" = "$STA_ENABLED" ]; then
	echo "syscfg parameters for sta:"
	echo "`syscfg show | grep wifi_sta`"
	echo "`syscfg show | grep lan_wl_physical`"
	STA_IF=`syscfg get wifi_sta_vir_if`
	LINK_STATUS=`iwpriv $STA_IF getlinkstatus | awk -F":" '{print $2}'`
	if [ "1" = "$LINK_STATUS" ]; then
		echo "`iwconfig $STA_IF`"
	else
		echo "STA is not connected!"
		echo "`iwpriv $STA_IF stamode 6; iwconfig $STA_IF commit; iwpriv $STA_IF stascan 1; sleep 5; iwpriv $STA_IF getstascan`"
	fi
fi
echo "========================== Wi-Fi Developpement Debug Information =========================="
echo "Site Survey on 2.4GHz:"
echo "`iwpriv wdev0sta0 stamode 7; iwconfig wdev0sta0 commit; iwpriv wdev0sta0 stascan 1; sleep 5; iwpriv wdev0sta0 getstascan`"
echo ""
echo "Site Survey on 5GHz:"
echo "`iwpriv wdev1sta0 stamode 8; iwconfig wdev1sta0 commit; iwpriv wdev1sta0 stascan 1; sleep 5; iwpriv wdev1sta0 getstascan`"
echo ""
echo "----- Dumping all driver internal configurations -----"
echo "Dumping all driver internal configurations for 2.4GHz:"
echo "`cat /proc/ap8x/wdev0ap0_stats`"
echo "`iwpriv wdev0ap0 -a`"
echo "Power table for 2.4GHz"
echo "`cat /etc/24G_power_table_FCC`"
echo ""
echo "Dumping all driver internal configurations for 5GHz:"
echo "`cat /proc/ap8x/wdev1ap0_stats`"
echo "`iwpriv wdev1ap0 -a`"
echo "Power table for 5GHz"
echo "`cat /etc/5G_power_table_FCC`"
echo ""
echo "Dumping all driver internal configurations for Guest Access:"
echo "`iwpriv wdev0ap1 -a`"
echo "========================== Ed Of Wi-Fi Developpement Debug Information =========================="
echo ""
