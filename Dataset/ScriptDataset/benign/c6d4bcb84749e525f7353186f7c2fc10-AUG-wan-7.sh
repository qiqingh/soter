  wan_eth1_mac=`ifconfig eth1 | sed -n '/HWaddr/p' | sed -e 's/.*HWaddr \(.*\)/\1/'`
  if [ "$1" = 1 ]; then
    cat >/tmp/dhcpc-wan.conf <<_EOFILE
send host-name "`nvram_get 2860 machine_name`";
send dhcp-client-identifier 01:${wan_eth1_mac};
request subnet-mask, routers, domain-name, domain-name-servers;
require subnet-mask, routers,
dhcp-lease-time, dhcp-server-identifier;
_EOFILE
	wireless_bridge=`nvram_get 2860 wbridge_mode`
	if [ "$wireless_bridge" = "0" ]; then
  		dhclient -nw -cf /tmp/dhcpc-wan.conf -sf /bin/dhcpc  \
   		-lf /tmp/dhcpc-wan.leases -pf /var/run/dhcpc-wan.pid -bm br0 eth1
	else
		wbridge_band=`nvram_get 2860 wbridge_band`
		if [ "$wbridge_band" = "0" ]; then
  			dhclient -nw -cf /tmp/dhcpc-wan.conf -sf /bin/dhcpc  \
   			-lf /tmp/dhcpc-wan.leases -pf /var/run/dhcpc-wan.pid -bm br0 apcli0 
		else
  			dhclient -nw -cf /tmp/dhcpc-wan.conf -sf /bin/dhcpc  \
   			-lf /tmp/dhcpc-wan.leases -pf /var/run/dhcpc-wan.pid -bm br0 apclix0 
		fi
	fi

  else
	ip=`nvram_get 2860 switch_ipaddr`
	nm=`nvram_get 2860 switch_netmask`
	gw=`nvram_get 2860 switch_gateway`
	pd=`nvram_get 2860 wan_primary_dns`
	sd=`nvram_get 2860 wan_secondary_dns`

	ifconfig $lan_if $ip netmask $nm
	route del default
	if [ "$gw" != "" ]; then
	 route add default gw $gw
	fi
	config-dns.sh $pd $sd
  fi

