   local output
   local rc=0
   ulog $SERVICE_NAME status "Registering with Linksys cloud"
   output=$(cloud_send_device_request registrations)
   rc=$?
   if [ $rc -eq 0 ]; then
      found=$(echo $output | grep "<linksysToken>")
      if [ "$found" ]; then
         local token=$(echo $found | cut -d'<' -f4 | sed "s/linksysToken>//g")
         syscfg set device::linksys_token $token
         syscfg commit
         ulog $SERVICE_NAME status "Cloud registation successful, token=$token"
         echo "$SERVICE_NAME: Cloud registation successful, token=$token" >> /dev/console
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
