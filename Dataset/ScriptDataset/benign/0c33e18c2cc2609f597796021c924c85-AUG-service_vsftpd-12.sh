  ulog vsftpd "unmount ftp shares"
  echo "umount_ftp_shares:" >> $TMP_LOG
  mount | grep "$MNT_DIR" | sed -r "s/^.* on (.*) type .*/\1/g" | sed "s|\040| |g" | while read file;
  do
    echo "vsftpd - unmounting $file" >> $TMP_LOG
  
    ulog vsftpd "unmounting $file"
  
    umount "$file"
    sync
    success=`mount | grep "$file "`
    if [ "$success" = "" ] ; then
      echo "vsftpd - unmounted $file, removing folder $file" >> $TMP_LOG
      ulog vsftpd "unmounted $file, removing folder $file"
      rmdir "$file"
    fi
    if [ -d "$file" ] ; then
      if [ -z "$(ls -A $file)" ] ; then
          ulog vsftpd "Found empty dir = $file and remove dir"
          rmdir "$file"
      fi
    fi
  done
  sync
  mount | grep "$MNT_DIR" | sed -r "s/^.* on (.*) type .*/\1/g" | sed "s|\040| |g" | sed "s/ (deleted)//g" | while read file;
  do
    ulog vsftpd "unmount ftp shares: $file" 
    umount "$file"
    sync
    rmdir "$file"
  done
