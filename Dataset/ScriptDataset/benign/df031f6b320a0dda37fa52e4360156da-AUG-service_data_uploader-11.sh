   local reason=$1
   local sections=$2
   local output
   local rc=0
   ulog $SERVICE_NAME status "Uploading sysinfo $sections"
   if [ -z "$reason" ]; then
      reason=USER_REQUEST
   fi
   /www/sysinfo_json.cgi $sections > $SYSINFO_FILE 2>/dev/null
   output=$(cloud_upload_files SYSINFO_LOG $reason $SYSINFO_FILE )
   rc=$?
   if [ $rc -ne 0 ]; then 
      eval $output
      ulog $SERVICE_NAME error "$CLOUD_ERROR_CODE $CLOUD_ERROR_DESC"
   else
      ulog $SERVICE_NAME status "Sysinfo upload successful, id=$output"
      echo $output
   fi
   rm -f $SYSINFO_FILE
   return $rc
