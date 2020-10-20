   ulog ddns status "$PID told to persist the ddns state"
   NEED_TO_PERSIST=0
   if [ -f $CACHE_FILE ]; then
      PERSISTED=`cat $CACHE_FILE_P 2>/dev/null | md5sum`
      CURRENT=`cat $CACHE_FILE 2>/dev/null | md5sum`
      
      if [ "$PERSISTED" != "$CURRENT" ]; then
         ulog ddns status "$PID ez_ipupdate cache file changed $PERSISTED != $CURRENT"
         NEED_TO_PERSIST=1
      else
         ulog ddns status "$PID ez_ipupdate cache file didn't changed"
      fi
   fi
   if [ -f $TZO_CACHE ]; then
      PERSISTED=`cat $TZO_CACHE_P 2>/dev/null | md5sum`
      CURRENT=`cat $TZO_CACHE 2>/dev/null | md5sum`
      
      if [ "$PERSISTED" != "$CURRENT" ]; then
         ulog ddns status "$PID tzoupdate cache file changed $PERSISTED != $CURRENT"
         NEED_TO_PERSIST=1
      else
        ulog ddns status "$PID tzoupdate cache file didn't changed"
      fi   
   fi
   if [ -f $NOIP_CACHE ]; then
      PERSISTED=`cat $NOIP_CACHE_P 2>/dev/null | md5sum`
      CURRENT=`cat $NOIP_CACHE 2>/dev/null | md5sum`
      
      if [ "$PERSISTED" != "$CURRENT" ]; then
         ulog ddns status "$PID noip cache file changed $PERSISTED != $CURRENT"
         NEED_TO_PERSIST=1
      else
        ulog ddns status "$PID noip cache file didn't change"
      fi   
   fi
   if [ "$NEED_TO_PERSIST" == "1" ]; then
      if [ ! -d $DDNS_PERSIST_DIR ]; then
         mkdir $DDNS_PERSIST_DIR
      fi
      if [ -d $DDNS_TMP_DIR ]; then
         ulog ddns status "$PID persisting the ddns state"
         cp -pf ${DDNS_TMP_DIR}/*.cache* $DDNS_PERSIST_DIR
      else
         ulog ddns status "$PID no ddns state to persist"   
      fi
   fi   
