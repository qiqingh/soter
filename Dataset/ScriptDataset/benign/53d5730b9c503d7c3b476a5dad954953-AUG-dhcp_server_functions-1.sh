   FOO=`utctx_cmd get lan_ifname dot_local_domain dot_local_hostname ula_enable lan_ula_prefix ui::remote_host ui::remote_host cloud::host xmpp_host device::modelNumber private_domain`
   eval $FOO
   if [ -n "$SYSCFG_dot_local_hostname" -a -n "$SYSCFG_dot_local_domain" ]
   then
      DOT_LOCAL_NAME=${SYSCFG_dot_local_hostname}.${SYSCFG_dot_local_domain}
   fi
   if [ -n "$SYSCFG_device_modelNumber" -a -n "$SYSCFG_private_domain" ]
   then
      LOCAL_NAME=${SYSCFG_device_modelNumber}.${SYSCFG_private_domain}
   fi
   if [ -n "$SYSCFG_ui_remote_host" ]
   then
      echo "server=/${SYSCFG_ui_remote_host}/#" >> $1
   fi
   if [ -n "$SYSCFG_cloud_host" -a "$SYSCFG_cloud_host" != "$SYSCFG_ui_remote_host" ]
   then
      echo "server=/${SYSCFG_cloud_host}/#" >> $1
   fi
   if [ -z "${SYSCFG_cloud_host##*.cloud1*}" ] ; then
      echo "server=/${SYSCFG_cloud_host/.cloud1/}/#" >> $1
   else
      echo "server=/${SYSCFG_cloud_host/cloud1./cloud.}/#" >> $1
   fi
   if [ -n "$SYSCFG_xmpp_host" -a "$SYSCFG_xmpp_host" != "$SYSCFG_ui_remote_host" -a "$SYSCFG_xmpp_host" != "$SYSCFG_cloud_host" ]
   then
      echo "server=/${SYSCFG_xmpp_host}/#" >> $1
   fi
   if [ -n "$DOT_LOCAL_NAME" ] ; then
      echo "address=/${DOT_LOCAL_NAME}/${SYSCFG_lan_ipaddr}" >> $1
   fi
   if [ -n "$LOCAL_NAME" ] ; then
      echo "address=/${LOCAL_NAME}/${SYSCFG_lan_ipaddr}" >> $1
   fi
   if [ -f ${CLOUD_DNS_NAMES_FILE} ] ; then
      while read line ; do
         echo "address=/${line}/${SYSCFG_lan_ipaddr}" >> $1;
      done < ${CLOUD_DNS_NAMES_FILE}
   fi
   if [ "1" != "$SYSCFG_User_Accepts_WiFi_Is_Unsecure" ] ; then
      echo "address=/apple.com/0.0.0.0" >> $1;
   fi
   if [ "1" = "$SYSCFG_ula_enable" -a -n "$SYSCFG_lan_ula_prefix" ] ; then
      eval `ip6calc -p $SYSCFG_lan_ula_prefix`
      PREFIX_LEN=${#PREFIX}
      if [ 1 -lt "$PREFIX_LEN" ] ; then
         PREFIX_LEN=`expr $PREFIX_LEN - 1`
         PREFIX=${PREFIX:0:$PREFIX_LEN}
      fi
      LOCAL_IPS=`/sbin/ip -6 addr show dev $SYSCFG_lan_ifname  | grep "inet6 " | grep $PREFIX | awk '{split($2,foo, "/"); print(foo[1]); }'`
      if [ -n "$LOCAL_IPS" ] ; then
         for LOCAL_IP in $LOCAL_IPS ; do
            if [ -n "$DOT_LOCAL_NAME" ] ; then
               echo "address=/${DOT_LOCAL_NAME}/${LOCAL_IP}" >> $1
            fi
            if [ -n "$LOCAL_NAME" ] ; then
               echo "address=/${LOCAL_NAME}/${LOCAL_IP}" >> $1
            fi
            if [ -f ${CLOUD_DNS_NAMES_FILE} ] ; then
               while read line ; do
                  echo "address=/${line}/${LOCAL_IP}" >> $1;
               done < ${CLOUD_DNS_NAMES_FILE}
            fi
         done
      fi
   fi
