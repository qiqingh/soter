  CurrentUsers=$(get_current_user_list)
  for cu in $CurrentUsers
  do
    if [ "$cu" == "$1" ] ; then
      echo "$cu"
    fi
  done
