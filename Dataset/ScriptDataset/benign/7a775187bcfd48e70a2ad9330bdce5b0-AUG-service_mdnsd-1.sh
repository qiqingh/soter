   killall $MDNSD > /dev/null 2>&1
   if [ "1" = "$SYSCFG_mdnsd_enabled" ] ; then
       ulog ${SERVICE_NAME} status "starting ${SERVICE_NAME} service" 
       if [ -z "$SYSCFG_bridge_mode" -o "0" = "$SYSCFG_bridge_mode" ] ; then
          if [ -n "$SYSCFG_dot_local_domain" -a -n "$SYSCFG_dot_local_hostname" -a "local" = "$SYSCFG_dot_local_domain" ] ; then
             echo "$SYSCFG_dot_local_hostname" > $MDNS_CONF_FILE
          fi
       else
          if [ -n "$SYSCFG_hostname" ] ; then
             echo "$SYSCFG_hostname" > $MDNS_CONF_FILE
          fi
       fi
       $MDNSD  > /dev/null 2>&1 &
       if [ -x "/sbin/dns-sd" ] ; then
          if [ -z "$SYSCFG_bridge_mode" -o "0" = "$SYSCFG_bridge_mode" ] ; then
             if [ -n "$SYSCFG_dot_local_domain" -a -n "$SYSCFG_dot_local_hostname" ] ; then
                HTTP_HOST=${SYSCFG_dot_local_domain}
             else 
                HTTP_HOST=${SYSCFG_hostname}
             fi
          else
             if [ -z "$SYSCFG_dot_local_domain" ] ; then
                HTTP_HOST=${SYSCFG_dot_local_domain}
             else   
                HTTP_HOST="local"
             fi
             if [ -n "$SYSCFG_hostname" ] ; then
                SYSCFG_dot_local_hostname=$SYSCFG_hostname
             else
                HTTP_HOST=
             fi
          fi
          if [ -n "$HTTP_HOST" ] ; then
             killall -TERM dns-sd > /dev/null 2>&1
             sleep 3
             /sbin/dns-sd -R ${SYSCFG_dot_local_hostname}  _http._tcp ${HTTP_HOST} ${SYSCFG_http_admin_port} &
          fi
       fi
   fi
   sysevent set ${SERVICE_NAME}-errinfo
   sysevent set ${SERVICE_NAME}-status "started"
