   FIREWALL_STATE=`sysevent get firewall-status`
   
   sysevent set ${SERVICE_NAME}-status stopping
   
   SAVEIFS=$IFS
   IFS=';'
   for detect in $SERVICE_DETECT_EVENTS ; do
      if [ -n "$detect" ] && [ " " != "$detect" ] ; then
         IFS=$SAVEIFS
         sm_rm_event $SERVICE_NAME "$detect"
         IFS=';'
      fi
   done
   IFS=$SAVEIFS
  
   if [ "$FIREWALL_STATE" != "starting" ]; then
      ulog $SERVICE_NAME status "$PID service_stop () restarts firewall"
      sysevent set firewall-restart
   fi
 
   sysevent set ${SERVICE_NAME}-status stopped
   ulog $SERVICE_NAME status "stopped"
