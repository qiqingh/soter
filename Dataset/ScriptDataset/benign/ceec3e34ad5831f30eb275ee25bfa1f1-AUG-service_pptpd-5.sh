	mkdir -p `dirname "$AUTH_FILE"`
	echo "" > "$AUTH_FILE"
	
	DEFAULT_USER="1"
	for i in `seq 1 10`
	do
		USER="`syscfg get pptpd::user_${i}_name`"
		if [ "$USER" != "" ] ; then
			DEFAULT_USER="0"
			VPN_PASSWORD="`syscfg get pptpd::user_${i}_pass`"
			echo -e "$USER\tPPTPD\t$VPN_PASSWORD\t*\n" >> $AUTH_FILE
		fi
	done
	if [ "$DEFAULT_USER" == "1" ] ; then
		VPN_USER="$dfc_username"
		echo "$SERVICE_NAME using default vpn user $VPN_USER"
		VPN_PASSWORD="$dfc_password"
		echo "$SERVICE_NAME using default vpn password $VPN_PASSWORD"
		echo -e "$VPN_USER\tPPTPD\t$VPN_PASSWORD\t*\n" > $AUTH_FILE
  fi
  sed -i '/^$/d' $AUTH_FILE
  # echo "$SERVICE_NAME auth file created" >> /dev/console
