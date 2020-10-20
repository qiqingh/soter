   local output
   local rc=0
   local symFile=/tmp/kallsyms_$$
   local uploadFiles=""
   local dataTypes=$(syscfg get diagnostics::auto_upload_data_types)
   if (echo $dataTypes | grep crashinfo > /dev/null); then
      cp /proc/kallsyms $symFile 2>/dev/null
      uploadFiles="$symFile,/tmp/panic"
   fi
   if (echo $dataTypes | grep sysinfo > /dev/null); then
      /www/sysinfo_json.cgi > $SYSINFO_FILE 2>/dev/null
      uploadFiles="$uploadFiles,$SYSINFO_FILE"
   fi
   ulog $SERVICE_NAME status "Uploading crash log"
   output=$(cloud_upload_files CRASH_LOG SYSTEM_CRASH $uploadFiles)
   rc=$?
   if [ $rc -ne 0 ]; then 
      eval $output
      ulog $SERVICE_NAME error "$CLOUD_ERROR_CODE $CLOUD_ERROR_DESC"
   else
      ulog $SERVICE_NAME status "Crash log upload complete, id=$output"
      echo $output
   fi
   rm -f $SYSINFO_FILE
   rm -f $symFile
   return $rc
