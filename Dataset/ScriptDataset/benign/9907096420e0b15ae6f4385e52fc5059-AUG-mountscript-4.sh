  local ret_string
  total=`df /mnt/$1/ | tail -1 | awk '{print $2}'`
  used=`df /mnt/$1/ | tail -1 | awk '{print $3}'`
  free=`df /mnt/$1/ | tail -1 | awk '{print $4}'`
  percent=`df /mnt/$1/ | tail -1 | awk '{print $5}'`
  ret_string="$total $used $free $percent"
  echo $ret_string  
