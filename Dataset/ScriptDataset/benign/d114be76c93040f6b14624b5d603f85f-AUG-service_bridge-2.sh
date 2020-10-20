   asyncid=`sysevent get ${SERVICE_NAME}_async_id_1`;
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_async_id_1
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_async_id_2`;
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_async_id_2
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_async_id_3`;
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_async_id_3
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_async_id_4`;
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_async_id_4
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_async_id_5`;
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_async_id_5
   fi
