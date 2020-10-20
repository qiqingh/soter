  USER_COUNT=`syscfg get user_count`
  ID_LIST=""
  for i in `seq 1 $USER_COUNT`
  do
    NEW_ID=`syscfg get user_${i}_id`
    ID_LIST="$ID_LIST$NEW_ID"
    if [ "$i" != "$USER_COUNT" ] ; then
      ID_LIST="$ID_LIST|"
    fi
  done
  AUTH_FILE=`syscfg get user_auth_file`
  grep -E "$ID_LIST" $AUTH_FILE > /tmp/.tmppwl
  mv -f /tmp/.tmppwl $AUTH_FILE
  INVALID_USERS=`grep -vE "$ID_LIST" /etc/passwd | grep "/tmp/ftp" | cut -d':' -f1`
  for i in $INVALID_USERS
  do
    sed -i "/^$i:.*$/d" /tmp/etc/.root/passwd
    sed -i "/^$i:.*$/d" /tmp/etc/.root/shadow
  done
  
