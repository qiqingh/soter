  ulog smbd "umount samba folders"
  
  if [ -d "$ANON_SMB_DIR" ] ; then
    mount | grep "$ANON_SMB_DIR/" | sed -r "s/^.* on (.*) type .*/\1/g" | sed "s|\040| |g" | while read file;
    do
      echo "smb - unmounting $file" >> $TMP_LOG
    
      ulog smbd "unmounting $file"
    
      umount "$file"
      sync
      success=`mount | grep "$file "`
      if [ "$success" == "" ] ; then
        ulog smbd "unmounted $file, removing folder $file"
        rmdir "$file"
      fi
    done
    mount | grep "$ANON_SMB_DIR" | sed -r "s/^.* on (.*) type .*/\1/g" | sed "s|\040| |g" | sed "s/ (deleted)//g" | while read file;
    do
      ulog smbd "unmount samba shares: $file" 
      umount "$file"
      sync
      rmdir "$file"
    done
  else
    mkdir -p "$ANON_SMB_DIR"
  fi
