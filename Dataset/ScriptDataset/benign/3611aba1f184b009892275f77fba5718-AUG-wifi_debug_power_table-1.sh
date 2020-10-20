	if [ "`syscfg get wl0_state`" = "up" ]; then
		rf_lockdown_enable=`iwpriv ra0 e2p 1f | grep "\[0x001F\]" | awk -F ':' '{print $2}'`
	else
		rf_lockdown_enable=`hexdump -C /dev/mtd2 | grep 00000010 | awk '{print $17}'`
	fi
	power_table=`ls -l /tmp/7615_SingleSKU.dat | awk '{print $11}'`
	if [ $rf_lockdown_enable = "0xFF00" -o $rf_lockdown_enable = "ff" ]; then
		case "$1" in
		ME)
			if [ $power_table = "/etc/7615_SingleSKU.dat_CM" ];then
				echo "e2p_value=MPT"
				echo "e2p_locked=$1"
			else
				echo "******Power table is ERROR******"
				echo "RF Lock Down: error"
				echo "SKU:power error($power_table);CM"
			fi
			;;
		AH)
			if [ $power_table = "/etc/7615_SingleSKU.dat_CM" ];then
				echo "e2p_value=MPT"
				echo "e2p_locked=$1"
			else
				echo "******Power table is ERROR******"
				echo "RF Lock Down: error"
				echo "SKU:power error($power_table);CM"
			fi
			;;
		CN)
			if [ $power_table = "/etc/7615_SingleSKU.dat_CN" ];then
				echo "e2p_value=MPT"
				echo "e2p_locked=$1"
			else
				echo "******Power table is ERROR******"
				echo "RF Lock Down: error"
				echo "SKU:power error($power_table);CN"
			fi
			;;
		esac
	else
		echo "******Power table is ERROR******"
		echo "RF Lock Down: error, ($rf_lockdown_enable);0xff00"
		echo "SKU:error"
	fi
