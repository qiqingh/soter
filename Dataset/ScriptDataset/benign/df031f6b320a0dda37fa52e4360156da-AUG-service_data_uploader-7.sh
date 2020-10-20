   local svcStatus=$(sysevent get ${SERVICE_NAME}-status)
   local newCronFile
   rm -f $(find /etc/cron/ -name upload_sysinfo.sh)
   rm -f $(find /etc/cron/ -name refresh_cloud_token.sh)
   if [ $svcStatus == "starting" ]; then
      local uploadEnabled=$(syscfg get diagnostics::sysinfo_periodic_upload_enabled)
      if [ "$uploadEnabled" == "1" ]; then 
         local runInterval=$(syscfg get diagnostics::sysinfo_upload_interval)
         newCronFile="/etc/cron/cron.${runInterval}/upload_sysinfo.sh"
         ulog $SERVICE_NAME status "Creating new cron job for ${runInterval} sysinfo uploads"
         cat > $newCronFile << EOF
#!/bin/sh
$0 upload_sysinfo SCHEDULED "$(syscfg get diagnostics::sysinfo_sections)"
EOF
         chmod 700 $newCronFile
      fi
      newCronFile="/etc/cron/cron.${TOKEN_REFRESH_INTERVAL}/refresh_cloud_token.sh" 
      cat > $newCronFile << EOF
#!/bin/sh
$0 get_token
EOF
      chmod 700 $newCronFile
   fi
