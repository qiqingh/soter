   local supportedTypes="CRASH_LOG SYSINFO_LOG DIAG_DATA"
   for i in ${supportedTypes}; do
      if [ "$1" == "$i" ]; then
         return 0
      fi
   done
   return 1
