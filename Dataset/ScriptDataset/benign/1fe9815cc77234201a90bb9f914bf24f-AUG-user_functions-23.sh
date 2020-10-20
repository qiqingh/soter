  exists=`cat $POSIX_PASS_FILE | grep "^file_admin:"`
  if [ "$exists" == "" ] ; then
   adduser -h /mnt/ftp -H -D file_admin
  fi
  exists=`cat $POSIX_GROUP_FILE | grep "^file_guest:"`
  if [ "$exists" == "" ] ; then
   addgroup file_guest
  fi
