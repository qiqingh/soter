	# To make switch related MC register setting for eth on platform mt7621
	# support lsdk
	if [ -f /sbin/config.sh ]; then     
	  echo "easymesh in lsdk ver"
	  . /sbin/config.sh
	fi
	
	# support openwrt 
	if [ -f /etc/kernel.config ]; then                         
	  echo "easymesh in openwrt ver"
	  . /etc/kernel.config
	fi
	
	if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_MT7621_ASIC" = "y" ]; then
	  echo "easymesh board name is 7621"
	  switch reg w 10 ffffffe0
	  switch reg w 34 8160816
	fi
