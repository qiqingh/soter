  cat >/tmp/dhcp6c-wan.conf <<_EOFILE
request dhcp6.name-servers, dhcp6.domain-search, dhcp6.sntp-servers;
send dhcp6.client-id 00:03:00:01:`web 2860 sys wanMacAddr`;
_EOFILE
