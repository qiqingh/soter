  DRIVES=$(get_all_media_drives)
  scntr=1
  labelcnt=0
  ulog smbd "create samba config using default USB drives"
  
  for d in $DRIVES
  do
    if is_shared_drive $d ; then
      ulog smbd "config: shared_drive : $d"
    else
      echo "" >> $SAMBA_CONF_FILE
      if [ "$DEFAULT_SHARE_NAME_CONVENTION" = "partition" ] ; then
        lbl=`usblabel "$d"`
        if [ "$lbl" ] ; then
          if [ -d "$ANON_SMB_DIR/$lbl" ] ; then
            newlabel=`mount | grep "$ANON_SMB_DIR/" | grep "$d " | sed 's/\\\\040/ /g' | awk -F " type" '{print $1}' | awk -F "on " '{print $2}' | awk -F "/" '{print $4}'`
            echo "[$newlabel]" >> $SAMBA_CONF_FILE
          else
            echo "[$lbl]" >> $SAMBA_CONF_FILE
          fi
        else
          echo "[$d]" >> $SAMBA_CONF_FILE
        fi
      elif [ "$DEFAULT_SHARE_NAME_CONVENTION" == "share" ] ; then
        echo "[share$scntr]" >> $SAMBA_CONF_FILE
      else
        echo "[$prod_name$scntr]" >> $SAMBA_CONF_FILE 
      fi
      
      echo "  path = /mnt/$d" >> $SAMBA_CONF_FILE
      echo "  create mask = 0777" >> $SAMBA_CONF_FILE
      echo "  directory mask = 0777" >> $SAMBA_CONF_FILE
      echo "  public = yes" >> $SAMBA_CONF_FILE
      echo "  writable = yes" >> $SAMBA_CONF_FILE
      echo "  browseable = yes" >> $SAMBA_CONF_FILE
      echo "  inherit acls = yes" >> $SAMBA_CONF_FILE
      if [ $ANON_ACCESS -gt 0 ] ; then
        echo "  guest ok = yes" >> $SAMBA_CONF_FILE
      else
        echo "  guest ok = no" >> $SAMBA_CONF_FILE
      fi
      scntr=`expr $scntr + 1`
    fi
  done
