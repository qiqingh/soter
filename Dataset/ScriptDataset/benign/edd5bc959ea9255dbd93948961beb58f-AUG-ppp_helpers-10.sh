   pidof wmon > /dev/null
   if [ $? -eq 0 ] ; then
      killall -SIGQUIT wmon
     LOOP=1
     while [ "10" -gt "$LOOP" ] ; do 
        pidof wmon > /dev/null
        if [ $? -eq 0 ] ; then
           sleep 1
           LOOP=`expr $LOOP + 1`
        else
        LOOP=10
        fi
     done
	 LOOP=1
     while [ "10" -gt "$LOOP" ] ; do
        pidof pppd > /dev/null
        if [ $? -eq 0 ] ; then
            sleep 1
            LOOP=`expr $LOOP + 1`
        else
            return 0
        fi
     done
   fi
