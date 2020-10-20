   if [ -z "$1" ] ; then
      ulog wan status "$PID register_dhcp_client_handlers called without parameters $1,$2. Ignoring"
      return
   else
      ulog wan status "$PID register_dhcp_client_handlers for wan $1"
   fi
   asyncid1=`sysevent async dhcp_client-restart /etc/init.d/service_wan/dhcp_link.sh $1`
   sysevent setoptions dhcp_client-restart $TUPLE_FLAG_EVENT
   sysevent set ${1}_async_id_1 "$asyncid1"
   asyncid2=`sysevent async dhcp_client-release /etc/init.d/service_wan/dhcp_link.sh $1`
   sysevent setoptions dhcp_client-release $TUPLE_FLAG_EVENT
   sysevent set ${1}_async_id_2 "$asyncid2"
   asyncid3=`sysevent async dhcp_client-renew /etc/init.d/service_wan/dhcp_link.sh $1`
   sysevent setoptions dhcp_client-renew $TUPLE_FLAG_EVENT
   sysevent set ${1}_async_id_3 "$asyncid3"
   asyncid4=`sysevent async dhcp_client-release_renew /etc/init.d/service_wan/dhcp_link.sh $1`
   sysevent setoptions dhcp_client-release_renew $TUPLE_FLAG_EVENT
   sysevent set ${1}_async_id_4 "$asyncid4"
