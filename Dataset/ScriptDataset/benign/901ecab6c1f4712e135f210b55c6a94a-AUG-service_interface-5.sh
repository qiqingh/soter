   MAX_TRIES=20
   TRIES=1
   while [ "$MAX_TRIES" -gt "$TRIES" ] ; do
      STATUS=`sysevent get ${SYSCFG_ifname}-status`
      if [ "starting" = "$STATUS" -o "stopping" = "$STATUS" ] ; then
         ulog interface status "$PID service_start waiting for status to change from $STATUS. Try ${TRIES} of ${MAX_TRIES}"
         sleep 1
         TRIES=`expr $TRIES + 1`
      else
         TRIES=$MAX_TRIES
      fi
   done
   STATUS=`sysevent get ${SYSCFG_ifname}-status`
   if [ "started" != "$STATUS" ] ; then
      if [ -n "$SYSCFG_dependency" -a "none" != "$SYSCFG_dependency" ] ; then
         ulog interface status "$PID service_start starting dependency $SYSCFG_dependency"
         `/etc/init.d/service_interface.sh ${SERVICE_NAME}-start ${SYSCFG_dependency}`
         TRIES=1
         while [ "$MAX_TRIES" -gt "$TRIES" ] ; do
            STATUS=`sysevent get ${SYSCFG_dependency}-status`
            if [ "started" = "$STATUS" ] ; then
               TRIES=$MAX_TRIES
            else
               sleep 1
               TRIES=`expr $TRIES + 1`
            fi
         done
         
         STATUS=`sysevent get ${SYSCFG_dependency}-status`
         if [ "started" != "$STATUS" ] ; then
            ulog interface status "$PID Unable to start dependency $SYSCFG_dependency. Cannot start $SYSCFG_ifname."
            return 255
         fi
      fi
      case "$SYSCFG_type" in
         switch)
            case "$SYSCFG_hardware_vendor_name" in 
               Broadcom)
                  is_nfsboot
                  nfs=$?
               ;;
               Marvell)
                  REPLACEMENT=`syscfg get wan_mac_addr`
                  ip link set ${SYSCFG_ifname} addr $REPLACEMENT             
               ;;
            esac
            ip link set $SYSCFG_ifname up
         ;;
         vlan)
            is_nfsboot
            nfs=$?
            if [ $nfs = "0" ] ; then
               return;
            fi
            if [ -z "$SYSCFG_virtual_ifnum" ] ; then
               ulog interface status "$PID vlan declared but no virtual_ifnum. Ignoring" 
               return 0
            fi
               
            case "$SYSCFG_hardware_vendor_name" in 
               Broadcom)
                     config_vlan $SYSCFG_dependency $SYSCFG_virtual_ifnum
               ;;
               Marvell)
                    vconfig add $SYSCFG_dependency $SYSCFG_virtual_ifnum
                    if [ "`syscfg get device::modelNumber`" = "WRT1900AC" ] ; then
                        REPLACEMENT=`syscfg get wan_mac_addr`
                        ip link set ${SYSCFG_ifname} down
                        ip link set ${SYSCFG_ifname} addr $REPLACEMENT
                        sysevent set ${SYSCFG_ifname}_mac $REPLACEMENT
                    else
                        REPLACEMENT=`sysevent get ${SYSCFG_ifname}_mac`
                        if [ -n "$REPLACEMENT" ] ; then
                            ip link set ${SYSCFG_ifname} addr $REPLACEMENT
                        else
                            ip link set ${SYSCFG_ifname} up
                            INCR_AMOUNT=`expr $SYSCFG_virtual_ifnum`
                            OUR_MAC=`get_mac ${SYSCFG_dependency}`
                            REPLACEMENT=`incr_mac $OUR_MAC $INCR_AMOUNT`
                            ip link set ${SYSCFG_ifname} down
                            ip link set ${SYSCFG_ifname}  addr $REPLACEMENT
                            sysevent set ${SYSCFG_ifname}_mac $REPLACEMENT
                        fi
                    fi
                    ;;
            esac
            ip link set $SYSCFG_ifname up
         ;;
      esac
      sysevent set ${SYSCFG_ifname}-status started
   fi
