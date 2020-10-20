    if [ ! -f /cgroup/tasks ]; then
        return
    fi
    if [ ! -d /cgroup/twonky ]; then
        mkdir -p /cgroup/twonky
        echo 3 > /proc/sys/vm/drop_caches
	if [ "`cat /etc/product`" != "panamera" ];then
	      echo 1 > /proc/sys/vm/compact_memory
	fi
        local mem
        mem=`grep -e '^MemTotal' /proc/meminfo | awk '{print $2}'`
        mem=`expr $mem / 4`
        local free
        free=`grep -e '^MemFree' /proc/meminfo | awk '{print $2}'`
        free=`expr $free - 10240`
        if [ "$mem" -gt "$free" ]; then
            mem=$free
        fi
        mem=`expr $mem \* 1024`
        echo "$mem" > /cgroup/twonky/memory.limit_in_bytes
        echo "1" > /cgroup/twonky/memory.oom_control
    fi
    echo 0 > /cgroup/twonky/tasks
