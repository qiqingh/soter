   if [ -z "$1" ] ; then
      ulog wan status "$PID unregister_dhcp_client_handlers called without parameter. Ignoring"
      return
   else
      ulog wan status "$PID unregister_dhcp_client_handlers for wan $1"
   fi
   asyncid1=`sysevent get ${1}_async_id_1`;
   if [ -n "$asyncid1" ] ; then
      sysevent rm_async $asyncid1
      sysevent set ${1}_async_id_1
   fi
   asyncid2=`sysevent get ${1}_async_id_2`;
   if [ -n "$asyncid2" ] ; then
      sysevent rm_async $asyncid2
      sysevent set ${1}_async_id_2
   fi
   asyncid3=`sysevent get ${1}_async_id_3`;
   if [ -n "$asyncid3" ] ; then
      sysevent rm_async $asyncid3
      sysevent set ${1}_async_id_3
   fi
   asyncid4=`sysevent get ${1}_async_id_4`;
   if [ -n "$asyncid4" ] ; then
      sysevent rm_async $asyncid4
      sysevent set ${1}_async_id_4
   fi
