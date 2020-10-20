    if [ -f $TMTHPD_PIDFILE ]; then
       echo "there is some process..."
       stop
    fi

    echo "Install iptable rules"
    ${BINDIR}/installipt.sh install

#    echo "Start up dnrd ..."
#    ${BINDIR}/dnrd -u 0 -s 168.95.1.1

    export LD_LIBRARY_PATH=../lib

    echo "Start up HTTP Proxy ..."
    ${BINDIR}/tmthpd ${TMSSS_ARG} &
    
