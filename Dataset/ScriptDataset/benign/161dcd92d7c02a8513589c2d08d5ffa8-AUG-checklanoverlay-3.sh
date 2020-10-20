		log "wan subnet is the same as lan, update lan setting!!!"
		if [ $(check_overlay $WANIP $WANMASK 192.168.11.1 255.255.255.0) = 1 ]; then
			log "Change lan ip to 192.168.1.1/24"
			objReq lan setparam ipaddr "192.168.1.1"
			objReq dhcps setparam startIp "192.168.1.100"
		else
			log "Change lan ip to 192.168.11.1/24"
			objReq lan setparam ipaddr "192.168.11.1"
			objReq dhcps setparam startIp "192.168.11.100"
		fi
		objReq lan setparam netmask "255.255.255.0"
		gnvram commit
		/etc/init.d/network restart
