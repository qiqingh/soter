	# GMAC1 need To config swith vlan
	# platform mt7621(only for certification mode use)
	# support openwrt
	if [ -f /etc/kernel.config ]; then
	  echo "easymesh in openwrt version"
	  . /etc/kernel.config
	  if [ "$CONFIG_RALINK_MT7621" = "y" -o\
	  "$CONFIG_MT7621_ASIC" = "y" ]; then
		echo "easymesh board name is 7621"
		if [ "${MapMode}" = "4" ]; then
		echo "mapmode is certification mode, config switch_setup "
		  . /lib/network/switch.sh
		  setup_switch
		fi
	  fi
	fi

