   grep -q "root=/dev/nfs .*$1" /proc/cmdline
   return $?
