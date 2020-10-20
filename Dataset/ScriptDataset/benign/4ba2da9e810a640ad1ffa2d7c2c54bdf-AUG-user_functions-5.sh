  gid=`cat $POSIX_GROUP_FILE | grep "file_admin:" | cut -d':' -f3`
  echo "$gid"
