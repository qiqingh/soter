  idx=$(get_user_index "$1")
  if [ "$idx" ] ; then
    uid=`syscfg get user_${idx}_id`
    echo "$uid"
  fi
