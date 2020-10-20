  cat >/tmp/dhcpc-wan.conf <<_EOFILE
send host-name "`nvram_get 2860 machine_name`";
send dhcp-client-identifier 01:`web 2860 sys wanMacAddr`;
request subnet-mask, routers, domain-name, domain-name-servers;
require subnet-mask, routers,
dhcp-lease-time, dhcp-server-identifier;
_EOFILE
