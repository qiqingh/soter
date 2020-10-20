  ulog vsftpd "mount anon ftp folders"
  chmod 755 "$MNT_DIR/anonymous"
  
  ftp_fldr_cnt=`syscfg get FTPFolderCount`
  if [ "$ftp_fldr_cnt" -gt "0" ] ; then
    ulog vsftpd "mount anon ftp folders using shared folders info" 
    for i in `seq 1 $ftp_fldr_cnt`
    do
      fldr_name=`syscfg get ftp_${i} name`
      fldr_drive=`syscfg get ftp_${i} drive`
      fldr_path=`syscfg get ftp_${i} folder`
      if [ -d "/mnt/$fldr_drive/$fldr_path" ] ; then
        mkdir "$MNT_DIR/anonymous/$fldr_name"
        mount -o umask=002 "/mnt/$fldr_drive/$fldr_path" "$MNT_DIR/anonymous/$fldr_name" -o bind
        chmod 775 "$MNT_DIR/anonymous/$fldr_name"
      else
        echo "could not find path /mnt/$fldr_drive/$fldr_path" >> $TMP_LOG
      fi
    done
  fi
  ulog vsftpd "mount anon ftp folders unsing default USB drives"
  DRIVES=`ls /mnt/ | grep -r "sd[a-z][0-9.]"`
  i="1"
  for d in $DRIVES
  do
    if is_shared_drive $d ; then
      ulog vsftpd "mount_anon: shared_drive $d"
    else
      dlabel=`usblabel $d`
      if [ "$dlabel" == "" ] ; then
        dlabel="$d"
      else
        if [ -d "$MNT_DIR/anonymous/$dlabel" ] ; then
          labelcnt=`mount | grep "$MNT_DIR/anonymous/" | sed -r "s/^.* on (.*) type .*/\1/g" | sed 's/\\\\040/ /g' | grep "$dlabel" | wc -l`
          if [ $labelcnt -gt 0 ] && [ 20 -gt $labelcnt ] ; then
            anonext="($labelcnt)"
          else
            anonext=""
          fi 
          dlabel="$dlabel$anonext"
        else
          echo "could not find path $MNT_DIR/anonymous/$dlabel" >> $TMP_LOG
        fi
      fi
      ulog vsftpd "ftp anon drive label = $dlabel"
      if [ -d "/mnt/$d" ] ; then
        mkdir "$MNT_DIR/anonymous/$dlabel"
        mount -o umask=002 /mnt/$d "$MNT_DIR/anonymous/$dlabel" -o bind
        chmod 775 "$MNT_DIR/anonymous/$dlabel"
        i=`expr $i + 1`
      else
        echo "could not find path /mnt/$d" >> $TMP_LOG
      fi
    fi
  done
