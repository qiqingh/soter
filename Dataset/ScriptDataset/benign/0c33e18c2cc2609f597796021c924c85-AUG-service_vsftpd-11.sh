  ulog vsftpd "mount ftp shares"
  echo "mount_ftp_shares:" >> $TMP_LOG
  COUNT=`syscfg get FTPFolderCount`
  [ -z "$COUNT" ] && COUNT=0
  if [ $COUNT -gt 0 ] ; then
    ulog vsftpd "mount ftp folders using shared folders info"
    echo "$COUNT ftp shares configured" >> $TMP_LOG
    for ct in `seq 1 $COUNT`
    do
      NAMESPACE="ftp_$ct"
      NAME=`syscfg get $NAMESPACE name`
      FOLDER=`syscfg get $NAMESPACE folder`
      DRIVE=`syscfg get $NAMESPACE drive`
      READONLY=`syscfg get $NAMESPACE readonly`
      GROUPS=`syscfg get $NAMESPACE groups | sed 's/,/ /g'`
      
      echo "" >> $TMP_LOG
      echo "FtpFolder_${ct} : $NAMESPACE" >> $TMP_LOG  
      echo "  name   : $NAME" >> $TMP_LOG  
      echo "  folder : $FOLDER" >> $TMP_LOG  
      echo "  drive  : $DRIVE" >> $TMP_LOG  
      echo "  ro     : $READONLY" >> $TMP_LOG
      echo "  groups : $GROUPS" >> $TMP_LOG
      
      for g in $GROUPS
      do
        if [ "$g" != "admin" ] && [ "$g" != "guest" ] ; then
          echo "checking for $MNT_DIR/$g" >> $TMP_LOG
          if [ -d "$MNT_DIR/$g" ] ; then
            if [ -d "/mnt/$DRIVE$FOLDER" ] ; then
              echo "creating $MNT_DIR/$g/$NAME" >> $TMP_LOG
              mkdir -p "$MNT_DIR/$g/$NAME"
              adjust_perms=$(get_group_perms "$g")
              echo "mounting $MNT_DIR/$g/$NAME has $adjust_perms permissions" >> $TMP_LOG
              echo "mounting /mnt/$DRIVE$FOLDER on $MNT_DIR/$g/$NAME" >> $TMP_LOG
              mount -o umask=002 "/mnt/$DRIVE$FOLDER" "$MNT_DIR/$g/$NAME" -o bind
              if [ "$adjust_perms" == "file_guest" ] ; then
                chmod 775 "$MNT_DIR/$g/$NAME"
              fi
            else
              echo "could not find path /mnt/$DRIVE$FOLDER" >> $TMP_LOG
            fi
          fi
        else
          if [ -d "/mnt/$DRIVE$FOLDER" ] ; then
            if [ -d "/mnt/$DRIVE$FOLDER" ] ; then
              if [ "$g" = "admin" ] ; then
                mkdir -p "$MNT_DIR_ADMIN/$NAME"
                echo "mounting /mnt/$DRIVE$FOLDER on $MNT_DIR_ADMIN/$NAME" >> $TMP_LOG
                mount -o umask=002 "/mnt/$DRIVE$FOLDER" "$MNT_DIR_ADMIN/$NAME" -o bind
              fi          
              if [ "$g" = "guest" ] ; then
                mkdir -p "$MNT_DIR_GUEST/$NAME"
                echo "mounting /mnt/$DRIVE$FOLDER on $MNT_DIR_GUEST/$NAME" >> $TMP_LOG
                mount -o umask=002 "/mnt/$DRIVE$FOLDER" "$MNT_DIR_GUEST/$NAME" -o bind
              fi
            else
              echo "could not find path /mnt/$DRIVE$FOLDER" >> $TMP_LOG
            fi
          fi
        fi
      done
    done
  fi
  ulog vsftpd "mount ftp folders using default USB drives"
  DRIVES=$(get_all_media_drives)
  dcount=1
  labelcnt=0
  for d in $DRIVES
  do
    if is_shared_drive $d ; then
      ulog vsftpd "mount_ftp: shared_drive $d"
    else 
      usb_label=`usblabel $d`
      if [ "$usb_label" ] ; then
        if [ -d "$MNT_DIR_ADMIN/$usb_label" ] ; then
          labelcnt=`mount | grep "$MNT_DIR_ADMIN/" | sed -r "s/^.* on (.*) type .*/\1/g" | sed 's/\\\\040/ /g' |grep "$usb_label" | wc -l`
          if [ $labelcnt -gt 0 ] && [ 20 -gt $labelcnt ] ; then
            anonext="($labelcnt)"
          else
            anonext=""
          fi
          if [ -d "/tmp/$d" ] ; then
            mkdir -p "$MNT_DIR_ADMIN/$usb_label$anonext"
            echo "mounting /tmp/$d on $MNT_DIR_ADMIN/$usb_label$anonext" >> $TMP_LOG
            mount -o umask=002 "/tmp/$d" "$MNT_DIR_ADMIN/$usb_label$anonext" -o bind
          else
            echo "could not find path /tmp/$d" >> $TMP_LOG
          fi
        else
          echo "could not find path $MNT_DIR_ADMIN/$usb_label" >> $TMP_LOG
          if [ -d "/tmp/$d" ] ; then
            mkdir -p "$MNT_DIR_ADMIN/$usb_label"
            echo "mounting /tmp/$d on $MNT_DIR_ADMIN/$usb_label" >> $TMP_LOG
            mount -o umask=002 "/tmp/$d" "$MNT_DIR_ADMIN/$usb_label" -o bind
          else
            echo "could not find path /tmp/$d" >> $TMP_LOG
          fi
        fi
      else
        if [ -d "/tmp/$d" ] ; then
        mkdir -p "$MNT_DIR_ADMIN/$d"
        echo "mounting /tmp/$d on $MNT_DIR_ADMIN/$d" >> $TMP_LOG
        mount -o umask=002 "/tmp/$d" "$MNT_DIR_ADMIN/$d" -o bind
        else
            echo "could not find path /tmp/$d" >> $TMP_LOG
        fi
      fi
    fi
    dcount=`expr $dcount + 1`
  done
