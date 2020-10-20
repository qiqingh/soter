  idx=$(get_user_index "$1")
  if [ "$idx" ] ; then
    perms=`syscfg get user_${idx}_perms`
    echo "$perms"
  fi
