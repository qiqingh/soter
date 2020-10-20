   unregister_dhcp_client_handlers
   asyncid=`sysevent async dhcp_client-start "$HANDLER"`;
   sysevent setoptions dhcp_client-start $TUPLE_FLAG_EVENT
   sysevent set ${SERVICE_NAME}_async_id_1 "$asyncid"
   asyncid=`sysevent async dhcp_client-stop "$HANDLER"`;
   sysevent setoptions dhcp_client-stop $TUPLE_FLAG_EVENT
   sysevent set ${SERVICE_NAME}_async_id_2 "$asyncid"
   asyncid=`sysevent async dhcp_client-restart "$HANDLER"`;
   sysevent setoptions dhcp_client-restart $TUPLE_FLAG_EVENT
   sysevent set ${SERVICE_NAME}_async_id_3 "$asyncid"
   asyncid=`sysevent async dhcp_client-release "$HANDLER"`;
   sysevent setoptions dhcp_client-release $TUPLE_FLAG_EVENT
   sysevent set ${SERVICE_NAME}_async_id_4 "$asyncid"
   asyncid=`sysevent async dhcp_client-renew "$HANDLER"`;
   sysevent setoptions dhcp_client-renew $TUPLE_FLAG_EVENT
   sysevent set ${SERVICE_NAME}_async_id_5 "$asyncid"
