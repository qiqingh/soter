  user_count=`syscfg get user_count`
  userlist=""
  for i in `seq 1 $user_count`
  do
    ugroup=`syscfg get user_${i}_group`
    if [ "$ugroup" == "$1" ] ; then
      uname=`syscfg get user_${i}_username`
      userlist="$uname $userlist"
    fi
  done
  echo "$userlist"
