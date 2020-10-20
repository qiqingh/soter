    eval `utctx_cmd get qos_enable wan_download_speed wan_upload_speed wan_upload_speed_unit lan_ethernet_virtual_ifnums lan_ethernet_physical_ifnames lan_wl_physical_ifnames wl0_user_vap wl1_user_vap wl0_guest_vap bridge_mode QoSEthernetPort_1 QoSEthernetPort_2 QoSEthernetPort_3 QoSEthernetPort_4 hardware_vendor_name QoSDefinedPolicyCount QoSUserDefinedPolicyCount QoSPolicyCount QoSMacAddrCount QoSVoiceDeviceCount`
    WAN_STATUS=`sysevent get wan-status`
    LAN_STATUS=`sysevent get lan-status`
   ORIGINAL_SYSCFG_qos_enable=$SYSCFG_qos_enable
   if [ -n "$SYSCFG_qos_enable" -a "0" != "$SYSCFG_qos_enable" ] ; then
      IMPLICIT_DISABLE=1
      if [ -n "$SYSCFG_QoSDefinedPolicyCount" -a "0" != "$SYSCFG_QoSDefinedPolicyCount" ] ; then
        IMPLICIT_DISABLE=0 
      fi
      if [ -n "$SYSCFG_QoSUserDefinedPolicyCount" -a "0" != "$SYSCFG_QoSUserDefinedPolicyCount" ] ; then
        IMPLICIT_DISABLE=0 
      fi
      if [ -n "$SYSCFG_QoSPolicyCount" -a "0" != "$SYSCFG_QoSPolicyCount" ] ; then
        IMPLICIT_DISABLE=0 
      fi
      if [ -n "$SYSCFG_QoSMacAddrCount" -a "0" != "$SYSCFG_QoSMacAddrCount" ] ; then
        IMPLICIT_DISABLE=0 
      fi
      if [ -n "$SYSCFG_QoSVoiceDeviceCount" -a "0" != "$SYSCFG_QoSVoiceDeviceCount" ] ; then
        IMPLICIT_DISABLE=0 
      fi
      if [ -n "$QoSEthernetPort_1" -o  -n "$QoSEthernetPort_2" -o  -n "$QoSEthernetPort_3" -o  -n "$QoSEthernetPort_4" ] ; then
        IMPLICIT_DISABLE=0 
      fi
      if [ "1" = "$IMPLICIT_DISABLE" ] ; then
      ulog ${SERVICE_NAME} status "No qos rules found. QoS has been implicitly disabled" 
      SYSCFG_qos_enable=0
      fi
   fi
   if [ -n "$SYSCFG_wan_upload_speed" ] ; then
      ZERO=`echo $SYSCFG_wan_upload_speed | cut -c1`
      if [ "0" = "$ZERO" ] ; then
         ZERO=`echo $SYSCFG_wan_upload_speed | cut -c2`
         if [ -n "$ZERO" ] ; then
            ZEROA=`echo $SYSCFG_wan_download_speed | cut -c3`
            if [ -z "$ZEROA" -o "0" = "$ZEROA" ] ; then
               ZEROB=`echo $SYSCFG_wan_download_speed | cut -c4`                   
               if [ -z "$ZEROB" -o "0" = "$ZEROB" ] ; then
                  ZEROC=`echo $SYSCFG_wan_download_speed | cut -c5`
                  if [ -z "$ZEROC" -o "0" = "$ZEROC" ] ; then    
                     ulog qos status "Implicitly changing wan_upload_speed from $SYSCFG_wan_upload_speed to 0"
                     SYSCFG_wan_upload_speed=0
                  fi
               fi
            fi
         fi
      fi
   fi
   if [ -n "$SYSCFG_wan_download_speed" ] ; then
      ZERO=`echo $SYSCFG_wan_download_speed | cut -c1`
      if [ "0" = "$ZERO" ] ; then
         ZERO=`echo $SYSCFG_wan_download_speed | cut -c2`
         if [ -n "$ZERO" ] ; then
            ZEROA=`echo $SYSCFG_wan_download_speed | cut -c3`
            if [ -z "$ZEROA" -o "0" = "$ZEROA" ] ; then
               ZEROB=`echo $SYSCFG_wan_download_speed | cut -c4`                   
               if [ -z "$ZEROB" -o "0" = "$ZEROB" ] ; then
                  ZEROC=`echo $SYSCFG_wan_download_speed | cut -c5`
                  if [ -z "$ZEROC" -o "0" = "$ZEROC" ] ; then   
                     ulog qos status "Implicitly changing wan_download_speed from $SYSCFG_wan_download_speed to 0"
                     SYSCFG_wan_download_speed=0
                  fi
               fi
            fi
         fi
      fi
   fi
   if [ -n "$SYSCFG_wan_download_speed" ] ; then
      TEST=`dc $SYSCFG_wan_download_speed .5 - p`
      RES=`echo $TEST | awk '{if (0 > $1) print 1; else print 0}'` 
      if [ "$RES" = "1" ] ; then
         ulog qos status "wan_download_speed too low ( $SYSCFG_wan_download_speed ). Resetting it"
         syscfg set wan_download_speed 0
         SYSCFG_wan_download_speed=0
      fi
   fi
   if [ -n "$SYSCFG_wan_upload_speed" ] ; then
      if [ "1" =  "$SYSCFG_wan_upload_speed_unit" ] ; then
         TEST=`dc $SYSCFG_wan_upload_speed 500 - p`
         RES=`echo $TEST | awk '{if (0 > $1) print 1; else print 0}'` 
         if [ "$RES" = "1" ] ; then
            ulog qos status "wan_upload_speed too low ( $SYSCFG_wan_upload_speed kbps). Resetting it"
            syscfg set wan_upload_speed 0
            SYSCFG_wan_upload_speed=0
         fi
      else
         TEST=`dc $SYSCFG_wan_upload_speed .500 - p`
         RES=`echo $TEST | awk '{if (0 > $1) print 1; else print 0}'` 
         if [ "$RES" = "1" ] ; then
            ulog qos status "wan_upload_speed too low ( $SYSCFG_wan_upload_speed mbps ). Resetting it"
            syscfg set wan_upload_speed 0
            SYSCFG_wan_upload_speed=0
         fi
      fi
   fi
   if [ "" = "$SYSCFG_lan_ethernet_virtual_ifnums" ] ; then
      LAN_IFNAMES=$SYSCFG_lan_ethernet_physical_ifnames
    else
       for loop in $SYSCFG_lan_ethernet_physical_ifnames
       do
         LAN_IFNAMES="$LAN_IFNAMES vlan$SYSCFG_lan_ethernet_virtual_ifnums"
       done
   fi
