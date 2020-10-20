  nm=`cat $POSIX_GROUP_FILE | grep ":$1:" | cut -d':' -f1`
  echo "$nm"
