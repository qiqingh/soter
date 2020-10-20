  uid=$(get_user_id "$1")
  echo `cat $USER_PASSFILE | grep "^$uid:" | cut -d':' -f2`
