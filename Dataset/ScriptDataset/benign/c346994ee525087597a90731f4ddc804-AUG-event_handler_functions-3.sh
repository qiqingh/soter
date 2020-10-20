  LSERVICE=$1
  TRIES=1
   while [ "20" -ge "$TRIES" ] ; do
      LSTATUS=`sysevent get ${LSERVICE}-status`
      if [ "starting" = "$LSTATUS" ] || [ "stopping" = "$LSTATUS" ] ; then
         sleep 1
         TRIES=`expr $TRIES + 1`
         if [ "$TRIES" -eq "19" ] ; then
            logger "wait_till_end_state: problem starting up ${LSERVICE}"
         fi
      else
         logger "wait_till_end_state: ${LSERVICE} - ${LSTATUS}"
         return
      fi
   done
