   SM_SERVICE=$1
   SM_EVENT_HANDLER=$2
   SM_CUSTOM_EVENTS=$3
   if [ -z "$SM_SERVICE" ] ; then
      return 1
   fi
   if [ -z "$SM_EVENT_HANDLER" ] ; then
      return 1
   fi
   sm_unregister $SM_SERVICE
   if [ "NULL" != "$SM_EVENT_HANDLER" ] ; then
      sm_register_for_default_events $SM_SERVICE $SM_EVENT_HANDLER
   fi
   if [ -n "$SM_CUSTOM_EVENTS" ] && [ "NULL" != "$SM_CUSTOM_EVENTS" ] ; then 
      SAVEIFS=$IFS
      IFS=';'
      for custom in $SM_CUSTOM_EVENTS ; do
         if [ -n "$custom" ] && [ " " != "$custom" ] ; then
            IFS=$SAVEIFS
            sm_register_one_event $SM_SERVICE "$custom"
            IFS=';'
         fi
      done
      IFS=$SAVEIFS
   fi
