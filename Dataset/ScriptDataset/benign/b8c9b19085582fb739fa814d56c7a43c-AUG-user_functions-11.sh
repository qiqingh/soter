  userlist=""
  for ct in `seq 1 $USER_COUNT`
  do
    user=`syscfg get user_${ct}_username`
    userlist="$user $userlist"
  done
  echo "$userlist"
