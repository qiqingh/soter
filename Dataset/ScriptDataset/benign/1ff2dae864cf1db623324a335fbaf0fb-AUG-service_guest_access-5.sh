	ulog guest_access status "bringing down guest access "
	ifconfig|grep -q $SYSCFG_guest_lan_ifname
	if [ $? = 0 ] ; then
		brctl delif $SYSCFG_guest_lan_ifname $SYSCFG_wl0_guest_vap
		ip link set $SYSCFG_guest_lan_ifname down
		ip addr flush dev $SYSCFG_guest_lan_ifname
		brctl delbr $SYSCFG_guest_lan_ifname
	fi
	
	cleanup_conntrack
	stop_guest_access
	echo "Guest access control is down " > /dev/console
