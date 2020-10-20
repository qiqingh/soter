   if [ -z "$1" -o -z "$2" ] ; then
      return 
   fi
   eval `ip6calc -p $2`
   create_eui_64 $1
   eval `ip6calc -o ${PREFIX} ::${EUI_64}`
   IPV6_FUNCTS_LAN_ADDRESS=$OR
   ulog ipv6_funct status "Assigning $IPV6_FUNCTS_LAN_ADDRESS to $1"
   ip -6 addr add ${IPV6_FUNCTS_LAN_ADDRESS}/64 dev $1 scope global  2>&1
   do_duplicate_address_detection $1 $IPV6_FUNCTS_LAN_ADDRESS
   IPV6_FUNCTS_RET_CODE=$?
   while [ "$IPV6_FUNCTS_RET_CODE" != "0" ] ; do
      ulog ipv6_funct status "$IPV6_FUNCTS_LAN_ADDRESS fails DAD. Removing from $1"
      ip -6 addr del ${IPV6_FUNCTS_LAN_ADDRESS}/64 dev $1 scope global  2>&1
      create_random_64 
      eval `ip6calc -o ${PREFIX} ::${RANDOM_64}`
      IPV6_FUNCTS_LAN_ADDRESS=$OR
      ulog ipv6_funct status "Assigning $IPV6_FUNCTS_LAN_ADDRESS to $1"
      ip -6 addr add ${IPV6_FUNCTS_LAN_ADDRESS}/64 dev $1 scope global  2>&1
      do_duplicate_address_detection $1 $IPV6_FUNCTS_LAN_ADDRESS
      IPV6_FUNCTS_RET_CODE=$?
   done
   sysevent set ${1}_dhcpv6_ia_pd_address ${IPV6_FUNCTS_LAN_ADDRESS}/64
