  for Uname in $USER_BLACKLIST
  do
    if [ "$1" == "$Uname" ] ; then
      echo "user $1 blacklisted"  >> $UTMP_LOG
    fi
  done
