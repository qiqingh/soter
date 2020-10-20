  gid=`cat $POSIX_GROUP_FILE | grep "file_guest:" | cut -d':' -f3`
  echo "$gid"
