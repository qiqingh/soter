  user_count=`syscfg get user_count`
  userlist=""
  for i in `seq 1 $user_count`
  do
    uname=`syscfg get user_${i}_username`
    ugroup=$(get_user_group "$uname")
    uperms=$(get_group_perms "$ugroup")
    
    if [ "$uperms" == "file_guest" ] ; then
      userlist="$uname,$userlist"
    fi
  done
  echo "$userlist"
