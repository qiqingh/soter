  SHARED_CNT=`syscfg get SharedFolderCount`
  
  [ -z "$SHARED_CNT" ] && return 1
  if [ $SHARED_CNT -gt 0 ] ; then
    for ct in `seq 1 $SHARED_CNT`
    do
      NAMESPACE="ftp_$ct"
      if [ "" != "$NAMESPACE" ] ; then
        DRIVE=`syscfg get $NAMESPACE drive`
        if [ "$DRIVE" = "$1" ] ; then
          return 0
        fi
      fi
    done
  fi
  
  return 1
