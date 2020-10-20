	if [ -z "$1" -o "$1" = "bridge" ]; then
                runif="ra0 rai0"
		rm -f /var/etc/miniupnpd-*
	else
                runif=$1
		rm -f /var/etc/miniupnpd-$1.conf
	fi

        for ifname in $runif;
        do
                CONFPATH="/var/etc/miniupnpd-$ifname.conf"
                PORTNUM=`expr 6352 + ${#ifname}`

		if [ "$1" != "bridge" ]; then
			echo "ext_ifname=$WANIF" > $CONFPATH
			echo "listening_ip=$LANIP/$LANMASK" >> $CONFPATH
			echo "port=$PORTNUM"  >> $CONFPATH
			echo "bitrate_up=800000000" >> $CONFPATH
			echo "bitrate_down=800000000" >> $CONFPATH
		fi
                echo "secure_mode=no" >> $CONFPATH
                echo "system_uptime=yes" >> $CONFPATH
                echo "notify_interval=30" >> $CONFPATH
                echo "uuid=$MINIUPNPDUUID" >> $CONFPATH
                echo "serial=$SN" >> $CONFPATH
                echo "model_number=1" >> $CONFPATH
                echo "enable_upnp=no" >> $CONFPATH
		echo "friendly_name=$SHOWNAME" >> $CONFPATH
		echo "model_name=Linksys Series Router $MODELNAME" >> $CONFPATH
		echo "user_conf=$USERCONF" >> $CONFPATH
		echo "user_disconnect=$USERDISCONNECT" >> $CONFPATH
        done
