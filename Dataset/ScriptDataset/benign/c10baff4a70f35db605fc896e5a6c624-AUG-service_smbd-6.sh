  ulog smbd "mount samba shares"
  echo "mount_samba_shares:" >> $TMP_LOG
  COUNT=`syscfg get SharedFolderCount`
  ANON_ACCESS=`syscfg get SharedFolderAnonEna`
  [ -z "$COUNT" ] && COUNT=0
  if [ $COUNT -gt 0 ] ; then
    ulog smbd "mount samba folders using shared folders info"
    echo "$COUNT samba shares configured" >> $TMP_LOG
    for ct in `seq 1 $COUNT`
    do
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
        echo "attempting to create share $NAME -> /mnt/$DRIVE$FOLDER" >> $TMP_LOG
        share_loc="/mnt/$DRIVE$FOLDER"
        if [ -d "$share_loc" ] ; then
          echo "/mnt/$DRIVE$FOLDER - Exists ( $share_loc )" >> $TMP_LOG
          if [ $ANON_ACCESS -gt 0 ] ; then
            mkdir -p "$ANON_SMB_DIR/$NAME"
            mount -o umask=000 "/mnt/$DRIVE$FOLDER" "$ANON_SMB_DIR/$NAME" -o bind
            chmod 777 "$ANON_SMB_DIR/$NAME"
          fi
        fi
      fi
    done
  fi
  ulog smbd "mount samba folders using default USB drives"
  DRIVES=$(get_all_media_drives)
  dcount=1
  labelcnt=0
  for d in $DRIVES
  do
    if is_shared_drive $d ; then
      ulog smbd "mount: shared_drive $d"
    else
      usb_label=`usblabel $d`
      if [ "$usb_label" != "" ] ; then
        if [ -d "$ANON_SMB_DIR/$usb_label" ] ; then
          labelcnt=`mount | grep "$ANON_SMB_DIR/"  | sed -r "s/^.* on (.*) type .*/\1/g" | sed 's/\\\\040/ /g' | grep "$usb_label" | wc -l`
          if [ $labelcnt -gt 0 ] && [ 20 -gt $labelcnt ] ; then
            anonext="($labelcnt)"
          else
            anonext=""
          fi
          mkdir -p "$ANON_SMB_DIR/$usb_label$anonext"
          echo "mounting /tmp/$d on $ANON_SMB_DIR/$usb_label$anonext" >> $TMP_LOG
          mount -o umask=002 "/tmp/$d" "$ANON_SMB_DIR/$usb_label$anonext" -o bind
        else
          mkdir -p "$ANON_SMB_DIR/$usb_label"
          echo "mounting /tmp/$d on $ANON_SMB_DIR/$usb_label" >> $TMP_LOG
          mount -o umask=002 "/tmp/$d" "$ANON_SMB_DIR/$usb_label" -o bind
        fi
      else
        mkdir -p "$ANON_SMB_DIR/$d"
        echo "mounting /tmp/$d on $ANON_SMB_DIR/--  $d" >> $TMP_LOG
        mount -o umask=002 "/tmp/$d" "$ANON_SMB_DIR/$d" -o bind
      fi
      dcount=`expr $dcount + 1`
    fi    
  done
