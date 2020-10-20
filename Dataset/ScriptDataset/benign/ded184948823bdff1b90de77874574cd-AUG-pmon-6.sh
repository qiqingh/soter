    if [ "" = "$1" ]; then
        echo "pmon-unsetproc: invalid parameter " > /dev/console
        return 1
    fi
    sysevent set pmon_proc_$1 
