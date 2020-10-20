   MY_STATE=`sysevent get ${SERVICE_NAME}-status`
   
   if [ "$MY_STATE" == "started" -o "$MY_STATE" == "starting" ]; then
         ulog $SERVICE_NAME status "$PID service_start () : but already started; just return"
         return
   fi
   
   sysevent set ${SERVICE_NAME}-status starting
   
   DMZ_ENABLED=`syscfg get dmz_enabled`
   : ${DMZ_ENABLED:=0}
   
   if [ $DMZ_ENABLED == "0" ]; then
      ulog $SERVICE_NAME status "$PID service_start () : dmz is disabled; just stop."
      sysevent set ${SERVICE_NAME}-status stopped
      return
   fi
   SAVEIFS=$IFS
   IFS=';'
   for detect in $SERVICE_DETECT_EVENTS ; do
      if [ -n "$detect" ] && [ " " != "$detect" ] ; then
         IFS=$SAVEIFS
         sm_register_one_event $SERVICE_NAME $detect
         IFS=';'
      fi
   done
   IFS=$SAVEIFS
     
   sysevent set ${SERVICE_NAME}-status started
      
   check_pre_conditions
   RET=$?
   
   if [ "$RET" == "1" ]; then
      provision_firewall
   fi
