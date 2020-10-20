    if [ "$(cat /sys/kernel/debug/gpio | grep "gpio${1} " | awk '{print $4}')" = "1" ]; then
        return 0
    fi
    
    return 1
