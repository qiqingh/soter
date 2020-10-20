  ulog vsftpd "unmount anon ftp folders"
  
  if [ -d "$MNT_DIR/anonymous" ] ; then
    DRIVES=`ls $MNT_DIR/anonymous`
    mount | grep "$MNT_DIR/anonymous" | sed -r "s/^.* on (.*) type .*/\1/g" | sed "s|\040| |g" | while read file;
    do
      echo "vsftpd - unmounting $file" >> $TMP_LOG
    
      ulog vsftpd "unmounting $file"
    
      umount "$file"
      sync
      success=`mount | grep "$file "`
      if [ "$success" = "" ] ; then
        ulog vsftpd "unmounted $file, removing folder $file"
        rmdir "$file"
      fi
    done
    mount | grep "$MNT_DIR/anonymous" | sed -r "s/^.* on (.*) type .*/\1/g" | sed "s|\040| |g" | sed "s/ (deleted)//g" | while read file;
    do
      ulog vsftpd "unmount ftp anon shares: $file" 
      umount "$file"
      sync
      rmdir "$file"
    done
  fi
