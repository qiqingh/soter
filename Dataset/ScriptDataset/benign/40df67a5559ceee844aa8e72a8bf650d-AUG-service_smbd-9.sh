  ulog smbd "create samba config using shared folder info"
  SHARE_CNT=`syscfg get SharedFolderCount`
  USB_DISK_COUNT=`ls /dev/ | grep -r "sd[a-z][0-9.]" | uniq | wc -l`
  
  if [ $USB_DISK_COUNT -gt 0 ] ; then
    [ -z "$SHARE_CNT" ] && SHARE_CNT=0
    if [ $SHARE_CNT -gt 0 ] ; then
      echo "share count = $SHARE_CNT" >> $TMP_LOG  
      for ct in `seq 1 $SHARE_CNT`
      do
        echo "share ${ct}." >> $TMP_LOG
        NAMESPACE="smb_$ct"
        if [ "" != "$NAMESPACE" ] ; then
          NAME=`syscfg get $NAMESPACE name`
          FOLDER=`syscfg get $NAMESPACE folder`
          DRIVE=`syscfg get $NAMESPACE drive`
          READONLY=`syscfg get $NAMESPACE readonly`
          GROUPS=`syscfg get $NAMESPACE groups | sed 's/,/ /g'`
          
          echo "" >> $TMP_LOG
          echo "SharedFolder_${ct}: $NAMESPACE" >> $TMP_LOG
          echo " name   : $NAME" >> $TMP_LOG
          echo " folder : .$FOLDER." >> $TMP_LOG
          echo " drive  : $DRIVE" >> $TMP_LOG
          echo " ro     : $READONLY" >> $TMP_LOG
          echo " groups : $GROUPS" >> $TMP_LOG
          share_loc="/mnt/$DRIVE$FOLDER"
          if [ -d "$share_loc" ] ; then
            echo "" >> $SAMBA_CONF_FILE
            if [ "$NAME" ] ; then
              echo "[$NAME]" >> $SAMBA_CONF_FILE
              echo "  path = /mnt/$DRIVE$FOLDER" >> $SAMBA_CONF_FILE
              echo "  inherit permissions = yes" >> $SAMBA_CONF_FILE
              echo "  create mask = 0777" >> $SAMBA_CONF_FILE
              echo "  directory mask = 0777" >> $SAMBA_CONF_FILE
              echo "  writable = yes" >> $SAMBA_CONF_FILE
              echo "  browseable = yes" >> $SAMBA_CONF_FILE
            fi
            
            if [ $ANON_ACCESS -gt 0 ] ; then
              echo "  public = yes" >> $SAMBA_CONF_FILE
              echo "  guest ok = yes" >> $SAMBA_CONF_FILE
            else
              echo "  guest ok = no" >> $SAMBA_CONF_FILE
              echo -n "  read list = ">> $SAMBA_CONF_FILE
              for g in $GROUPS
              do
                users=$(get_group_users "$g")
                ngperms=$(get_group_perms "$g")
                if [ "$ngperms" == "file_guest" ] ; then
                  if [ "$users" ] ; then
                    for u in $users
                    do
                      if [ "$u" != "root" ] ; then
                        echo -n "$u, " >> $SAMBA_CONF_FILE
                      fi
                    done
                  fi
                fi
              done
              echo "" >> $SAMBA_CONF_FILE
              echo -n "  write list = " >> $SAMBA_CONF_FILE
              for g in $GROUPS
              do
                users=$(get_group_users "$g")
                ngperms=$(get_group_perms "$g")
                if [ "$ngperms" == "file_admin" ] ; then
                  if [ "$users" ] ; then
                    for u in $users
                    do
                      if [ "$u" != "root" ] ; then
                        echo -n "$u, " >> $SAMBA_CONF_FILE
                      fi
                    done
                  fi
                fi
              done
              echo "" >> $SAMBA_CONF_FILE
              echo -n "  valid users = " >> $SAMBA_CONF_FILE
              for g in $GROUPS
              do
                users=$(get_group_users "$g")
                if [ "$users" ] ; then
                  for u in $users
                  do
                    if [ "$u" != "root" ] ; then
                      echo -n "$u, " >> $SAMBA_CONF_FILE
                    fi
                  done
                fi
              done
              echo "" >> $SAMBA_CONF_FILE
              echo -n "  admin users = " >> $SAMBA_CONF_FILE
              for g in $GROUPS
              do
                users=$(get_group_users "$g")
                ngperms=$(get_group_perms "$g")
                if [ "$ngperms" == "file_admin" ] ; then
                  if [ "$users" ] ; then
                    for u in $users
                    do
                      if [ "$u" != "root" ] ; then
                        echo -n "$u, " >> $SAMBA_CONF_FILE
                      fi
                    done
                  fi
                fi
              done
              echo "" >> $SAMBA_CONF_FILE
            fi
          fi
        fi
      done
    fi
  fi
