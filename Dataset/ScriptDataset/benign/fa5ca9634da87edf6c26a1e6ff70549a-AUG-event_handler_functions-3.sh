  LSERVICE=$1
  TRIES=1
   while [ "45" -ge "$TRIES" ] ; do
      LSTATUS=`sysevent get ${LSERVICE}-status`
      if [ "starting" = "$LSTATUS" ] || [ "stopping" = "$LSTATUS" ] ; then
         sleep 1
         TRIES=`expr $TRIES + 1`
         if [ "$TRIES" -eq "44" ] ; then
            logger "wait_till_end_state: did not reach end state; still $LSTATUS for ${LSERVICE}"
         fi
      else
         logger "wait_till_end_state: ${LSERVICE} - ${LSTATUS}"
         return
      fi
   done
