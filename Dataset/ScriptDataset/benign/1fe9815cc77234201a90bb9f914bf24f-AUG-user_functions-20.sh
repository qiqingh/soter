  lastuid=`tail -n 1 $POSIX_PASS_FILE | cut -d':' -f3`
  lastgid=`tail -n 1 $POSIX_GROUP_FILE | cut -d':' -f3`
  if [ $lastgid -gt $lastuid ] ; then
    nid=`expr $lastgid + 1`
  else
    nid=`expr $lastuid + 1`
  fi
  if [ $nid -lt $MIN_USER_ID ] ; then
    nid=`expr $MIN_USER_ID + 1`
  fi
  echo "$nid"
