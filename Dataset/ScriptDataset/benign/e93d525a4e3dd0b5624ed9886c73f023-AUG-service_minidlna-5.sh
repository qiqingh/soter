   if [ ! -f /cgroup/tasks ] ; then
      return
   fi
   if [ ! -d /cgroup/minidlna ] ; then
      mkdir -p /cgroup/minidlna
      echo 3 > /proc/sys/vm/drop_caches
      local mem
      mem=`grep -e '^MemTotal' /proc/meminfo | awk '{print $2}'` 
      mem=`expr $mem / 4`
      local free
      free=`grep -e '^MemFree' /proc/meminfo | awk '{print $2}'` 
      free=`expr $free - 10240`
      if [ "$mem" -gt "$free" ] ; then
         mem=$free
      fi
      mem=`expr $mem \* 1024`
      echo "$mem" > /cgroup/minidlna/memory.limit_in_bytes
      echo 1 > /cgroup/minidlna/memory.oom_control
   fi
   echo 0 > /cgroup/minidlna/tasks
