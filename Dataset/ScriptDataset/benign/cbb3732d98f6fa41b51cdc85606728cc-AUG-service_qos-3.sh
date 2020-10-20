   for i in wan_1 wan_2 wan_3
   do
      wan_info_by_namespace $i
      LOCAL_STATUS=`sysevent get ${i}-status`
      if [ "started" = "$LOCAL_STATUS" -a -n "$SYSEVENT_current_wan_ifname" ] ; then
         if [ -z "$SYSCFG_wan_download_speed" ] ; then
            SYSCFG_wan_download_speed=2097
         fi
         RES=`echo $SYSCFG_wan_download_speed 0 | awk '{if (0 >= $1) print 1; else print 0}'`
         if [ "$RES" = "1" ] ; then
            SYSCFG_wan_download_speed=2097
         fi
         if [ -z "$SYSCFG_wan_upload_speed" ]  ; then
            SYSCFG_wan_upload_speed=314
            SYSCFG_wan_upload_speed_unit=2 
         fi
         RES=`echo $SYSCFG_wan_upload_speed 0 | awk '{if (0 >= $1) print 1; else print 0}'`
         if [ "$RES" = "1" ] ; then
            SYSCFG_wan_upload_speed=314
            SYSCFG_wan_upload_speed_unit=2 
         fi
         if [ -z "$SYSCFG_wan_upload_speed_unit" ] ; then
            SYSCFG_wan_upload_speed_unit=2 
         fi
         if [ "$SYSCFG_wan_upload_speed_unit" = "1" ] ; then
            SYSCFG_wan_upload_speed=`dc $SYSCFG_wan_upload_speed 1000 \/ p`
            SYSCFG_wan_upload_speed_unit=2
         fi
         if [ "$SYSCFG_wan_upload_speed_unit" = "2"] && [$SYSCFG_wan_upload_speed -ge 314 ] ; then
             return
         else
             prepare_wan_qos_queue_disciplines $SYSEVENT_current_wan_ifname $SYSCFG_wan_download_speed $SYSCFG_wan_upload_speed
             ulog qos status "Enable QoS on $SYSEVENT_current_wan_ifname $SYSCFG_wan_download_speed $SYSCFG_wan_upload_speed"
         fi
      fi
   done
