	SYSCFG_FAILED='false'
	FOO=`utctx_cmd get guest_enabled wl0_guest_enabled wl1_guest_enabled wl0_state wl1_state guest_lan_netmask guest_subnet guest_lan_ifname guest_lan_ipaddr guest_lan_netmask wl0_guest_vap wl1_guest_vap`
	eval $FOO
	if [ $SYSCFG_FAILED = 'true' ] ; then
		ulog guest_access status "$PID utctx failed to get some configuration data"
		ulog guest_access status "$PID GUEST ACCESS CANNOT BE CONTROLLED"
		exit
	fi
