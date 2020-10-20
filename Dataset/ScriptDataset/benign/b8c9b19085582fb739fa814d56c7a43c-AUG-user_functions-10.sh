  admins=$(get_file_admin_usernames)
  guests=$(get_file_guest_usernames)
  adminid=$(get_file_admin_group_id)
  guestid=$(get_file_guest_group_id)
    
  sed -i "s/^file_admin:.*/file_admin:x:$adminid:$admins/g" $POSIX_GROUP_FILE
  sed -i "s/^root:.*/root:x:0:root,$admins/g" $POSIX_GROUP_FILE
  sed -i "s/^file_guest:.*/file_guest:x:$guestid:$guests/g" $POSIX_GROUP_FILE
