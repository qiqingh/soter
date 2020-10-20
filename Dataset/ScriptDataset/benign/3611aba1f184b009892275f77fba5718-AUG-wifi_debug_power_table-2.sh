	if [ "`syscfg get wl0_state`" = "up" ]; then
		rf_lockdown_enable=`iwpriv ra0 e2p 1f | grep "\[0x001F\]" | awk -F ':' '{print $2}'`
	else
		rf_lockdown_enable=`hexdump -C /dev/mtd2 | grep 00000010 | awk '{print $17}'`
	fi
	case "$1" in
	US)
		if [ $rf_lockdown_enable = "0x5580" -o $rf_lockdown_enable = "80" ]; then
			echo "e2p_value=Locked"
			echo "e2p_locked=$1"
		else
			echo "******Power table is ERROR******"
			echo "RF Lock Down: error, ($rf_lockdown_enable);0x5580"
			echo "SKU:error"
		fi
		;;
	CA)
		if [ $rf_lockdown_enable = "0x4381" -o $rf_lockdown_enable = "81" ]; then
			echo "e2p_value=Locked"
			echo "e2p_locked=$1"
		else
			echo "******Power table is ERROR******"
			echo "RF Lock Down: error, ($rf_lockdown_enable);0x4381"
			echo "SKU:error"
		fi
		;;
	EU)
		if [ $rf_lockdown_enable = "0x4582" -o $rf_lockdown_enable = "82" ]; then
			echo "e2p_value=Locked"
			echo "e2p_locked=$1"
		else
			echo "******Power table is ERROR******"
			echo "RF Lock Down: error, ($rf_lockdown_enable);0x4582"
			echo "SKU:error"
		fi
		;;
	HK)
		if [ $rf_lockdown_enable = "0x4885" -o $rf_lockdown_enable = "85" ]; then
			echo "e2p_value=Locked"
			echo "e2p_locked=$1"
		else
			echo "******Power table is ERROR******"
			echo "RF Lock Down: error, ($rf_lockdown_enable);0x4885"
			echo "SKU:error"
		fi
		;;
	*)
		echo "******Power table is ERROR******"
		echo "RF Lock Down: error, ($rf_lockdown_enable)"
		echo "SKU:error, $1"
	esac
