   TIMEOUT=$1
   : ${TIMEOUT:=12}
   TARGET=$TZO_POLL_1_FILENAME
   rm -f $TARGET
   
   sysevent set tzo_last_poll_time `get_current_time`
   
   create_tzo_poll_handler $TIMEOUT $TARGET 
