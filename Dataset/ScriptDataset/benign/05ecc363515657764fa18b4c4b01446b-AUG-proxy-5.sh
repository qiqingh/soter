
    killall tmthpd
    # replace "killall" to "kill -9 PID_NUM" to solve the unkillable case
    #killall tmchecker
    #if [ -f $CHECKER_PIDFILE ]; then
    #    kill -9 `cat $CHECKER_PIDFILE`
    #    # The shared memory key, 0x777, is defined in tmGetAU.h
    #    ipcrm -M 0x777
    #    RETVAL=$?
    #    if [ "${RETVAL}" != 0 ]; then
    #        fail
    #    else
    #        rm -f $CHECKER_PIDFILE
    #        ok
    #    fi
    #else
    #    fail
    #fi
    
    echo "Remove iptable rules"
    ${BINDIR}/installipt.sh remove
