   local supportedTypes="CRASH_LOG SYSINFO_LOG"
   if echo $supportedTypes | grep $1 >/dev/null; then
      true
   else 
      false
   fi
