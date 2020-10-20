   local emailTo=$1
   local output
   local rc=0
   ulog $SERVICE_NAME status "uploading sysinfo for email to: $emailTo"
   /www/sysinfo.cgi > $SYSINFO_FILE 2>/dev/null
   output=$(cloud_upload_files DIAG_DATA USER_REQUEST $SYSINFO_FILE "" $emailTo)
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
