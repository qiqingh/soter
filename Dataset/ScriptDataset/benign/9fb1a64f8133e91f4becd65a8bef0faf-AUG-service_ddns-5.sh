   LOCAL_CONF_FILE=$1
   DYNDNS_ADDR=$2
   
   MODEL=`syscfg get device::modelNumber`
   HW_REV=`syscfg get device::hw_revision`
   FW_VERSION=`syscfg get fwup_firmware_version`
   
   echo "service-type=$SYSCFG_ddns_service" > $LOCAL_CONF_FILE
   echo "user=${SYSCFG_ddns_username}:${SYSCFG_ddns_password}" >> $LOCAL_CONF_FILE
   echo "host=${SYSCFG_ddns_hostname}" >> $LOCAL_CONF_FILE
   echo "interface=$WAN_IFNAME" >> $LOCAL_CONF_FILE
   echo "agent=$MODEL" >> $LOCAL_CONF_FILE
   echo "address=$DYNDNS_ADDR" >> $LOCAL_CONF_FILE
   echo "max-interval=2073600" >> $LOCAL_CONF_FILE
   echo "cache-file=$CACHE_FILE" >> $LOCAL_CONF_FILE
   echo "retrys=1" >> $LOCAL_CONF_FILE
   if [ "" != "$SYSCFG_ddns_mx" ]; then
      echo "mx=$SYSCFG_ddns_mx" >> $LOCAL_CONF_FILE
      if [ "1" = "$SYSCFG_ddns_mx_backup" ] ; then
         echo "backmx=YES" >> $LOCAL_CONF_FILE
      fi
   fi
   if [ "1" = "$SYSCFG_ddns_wildcard" ] ; then
      echo "wildcard" >> $LOCAL_CONF_FILE
   fi
