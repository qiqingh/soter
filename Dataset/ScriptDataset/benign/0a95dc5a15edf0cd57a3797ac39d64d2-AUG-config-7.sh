    if [ -n "${raw_printk}" ]; then
        echo ${raw_printk} > ${printk}
        
        raw_printk=""
    fi
