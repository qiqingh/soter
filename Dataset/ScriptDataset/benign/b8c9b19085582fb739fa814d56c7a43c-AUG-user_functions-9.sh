  perms=""
  cnt=`syscfg get group_count`
  for i in `seq 1 $cnt`
  do
    name=`syscfg get group_${i}_name`
    if [ "$name" == "$1" ] ; then
      perms=`syscfg get group_${i}_perms`
    fi
  done
  echo "$perms"
