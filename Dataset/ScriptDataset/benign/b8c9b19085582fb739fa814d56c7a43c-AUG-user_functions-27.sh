  cnt=$(get_user_count)
  idx=$(get_user_index "$1")
  
  if [ "$idx" == "" ] ; then
    echo "no user $1 found"  >> $UTMP_LOG
    exit
  fi
  
  remove_user_passwords "$1"
  uid=`syscfg get user_${idx}_id`
  if [ "$cnt" == "$idx" ] ; then
    syscfg unset user_${cnt}_username
    syscfg unset user_${cnt}_id
    syscfg unset user_${cnt}_perms
  else
    replace_username=`syscfg get user_"$cnt"_username`
    replace_userid=`syscfg get user_"$cnt"_id`
    replace_userperms=`syscfg get user_"$cnt"_perms`
    syscfg set user_${idx}_username "$replace_username"
    syscfg set user_${idx}_id "$replace_userid"
    syscfg set user_${idx}_perms "$replace_userperms"
    syscfg unset user_${cnt}_username
    syscfg unset user_${cnt}_id
    syscfg unset user_${cnt}_perms
    cnt=`expr $cnt - 1`
  fi
