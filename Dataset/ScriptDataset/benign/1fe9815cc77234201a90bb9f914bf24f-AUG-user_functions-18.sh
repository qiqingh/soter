  idx=$(get_user_index "$1")
  if [ "$idx" ] ; then
    echo `syscfg get user_${idx}_group`
  fi
