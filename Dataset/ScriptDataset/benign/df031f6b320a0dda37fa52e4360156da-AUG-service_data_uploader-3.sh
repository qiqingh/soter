   local output
   local rc=0
   ulog $SERVICE_NAME status "Getting Linksys token"
   output=$(cloud_send_device_request tokens)
   rc=$?
   if [ $rc -eq 0 ]; then
      found=$(echo $output | grep "<linksysToken>")
      if [ "$found" ]; then
         local token=$(echo $found | cut -d'<' -f4 | sed "s/linksysToken>//g")
         syscfg set device::linksys_token $token
         syscfg commit
         echo "$SERVICE_NAME: Received token $token" >> /dev/console
         ulog $SERVICE_NAME status "Received token: $token"
         echo $token
      else  # unknown error
         rc=3
      fi
   else
      eval $output
   fi
   if [ $rc -ne 0 ]; then
      ulog $SERVICE_NAME error "$CLOUD_ERROR_CODE $CLOUD_ERROR_DESC"
   fi
   return $rc
