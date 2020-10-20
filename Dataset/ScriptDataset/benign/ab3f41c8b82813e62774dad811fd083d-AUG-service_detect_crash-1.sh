   local svcName=$1
   local i=0
   while [ $i -lt 5 ] && [ "$(sysevent get ${svcName}-status)" != "started" ]; do
      echo "${SERVICE_NAME}: waiting $svcName to start" >>/dev/console
      sleep 1
      i=`expr $i + 1`
   done
   if [ $i -eq 5 ]; then
      echo "${SERVICE_NAME}: $svcName never started" >>/dev/console
      false
   else
      true
   fi
