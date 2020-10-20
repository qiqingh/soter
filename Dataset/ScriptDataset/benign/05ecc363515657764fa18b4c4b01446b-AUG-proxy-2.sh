    echo -n $"Reloading: "

    if [ -f $TMTHPD_PIDFILE ]; then
       kill -HUP `cat $TMTHPD_PIDFILE`
       RETVAL=$?
       if [ "${RETVAL}" != 0 ]; then
          fail
       else
          ok
       fi
    else
       fail
    fi

