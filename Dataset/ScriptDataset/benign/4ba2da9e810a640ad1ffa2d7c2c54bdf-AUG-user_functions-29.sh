  echo "sync_file_users:" >> $UTMP_LOG
  NUM_USERS=`syscfg get user_count`
  if [ "" = "$NUM_USERS" ] || [ "0" = "$NUM_USERS" ] ; then
      echo "error no users found!"  >> $UTMP_LOG
      exit 0;
  fi
  for ct in `seq 1 $NUM_USERS`
  do
    u=`syscfg get user_${ct}_username`
    un="$u"
    pt_pass=$(get_user_password "$u")
    uid=$(get_user_id "$u")
    ugroup=$(get_user_group "$u")
    CONFIGD_GROUPS=`syscfg show | grep group_ | grep _name | cut -d'=' -f2`
    g_deleted=0
    for cg in $CONFIGD_GROUPS
    do
      if [ "$cg" == "$ugroup" ] ; then
        g_deleted=1
      fi
    done
    if [ $g_deleted -eq 0 ] ; then
      syscfg set user_${ct}_group guest
      ugroup="guest"
    fi
    uperms=$(get_group_perms "$ugroup")
    uenabled=$(get_user_enabled "$u")
    bl=$(check_user_blacklist "$u")
    
    echo "" >> $UTMP_LOG
    echo "user_${ct}" >> $UTMP_LOG
    echo "username : $u" >> $UTMP_LOG
    echo "syscfg'd : $un" >> $UTMP_LOG
    echo "pt_pass  : $pt_pass" >> $UTMP_LOG
    echo "uid      : $uid" >> $UTMP_LOG
    echo "perms    : $uperms" >> $UTMP_LOG
    echo "group    : $ugroup" >> $UTMP_LOG
    echo "enabled  : $uenabled" >> $UTMP_LOG  
    
    if [ "$uenabled" == "1" ] ; then
      if [ ! "$bl" ] ; then
        if [ "$un" == "" ] ; then
          echo "user $u not found in syscfg" >> $UTMP_LOG
        else   
          if [ "$u" ] && [ "$pt_pass" ] && [ "$uid" ] && [ "$uperms" ] ; then
            echo "sync_user $u $pt_pass $uid $uperms" >> $UTMP_LOG
            sync_user $u $pt_pass $uid $uperms
          else
            echo "error syncing user $u"  >> $UTMP_LOG
          fi
        fi
      else
        echo "skipping user $u ( black listed )" >> $UTMP_LOG
      fi
    else
      echo "user $u disabled in syscfg" >> $UTMP_LOG
      remove_user_passwords "$u"
    fi
  done
  do_group_entries
  echo "all users synced"  >> $UTMP_LOG
  filter_valid_users
