    REMOVE_LIST=`$IPTABLES -t nat -L PREROUTING -n --line-numbers | $AWK "/REDIRECT.+$BOX_IP.+tcp dpt:$REDIR_SRC_PORT redir ports $REDIR_TO_PORT/{print \\$1}" | sort -r`
    #echo "[" `date '+%Y.%m.%d %H:%M:%S'` "]:Remove List:" $REMOVE_LIST >> $IPT_LOG
    for i in $REMOVE_LIST ; do
        #echo "iptables -t nat -D PREROUTING $i"
        $IPTABLES -t nat -D PREROUTING $i
        #echo "[" `date '+%Y.%m.%d %H:%M:%S'` "]:iptables -t nat -D PREROUTING $i" >> $IPT_LOG
    done
