  userlist=$(get_current_user_list)
  if [ "$userlist" ] ; then
    echo -n "" > $SAMBA_PASS_FILE
    for un in $userlist
    do
      pword=$(get_user_password "$un")
      if [ "$pword" ] ; then
      (echo "$pword"; echo "$pword") | /bin/smbpasswd -as "$un" > /dev/null
      fi
    done
  fi
