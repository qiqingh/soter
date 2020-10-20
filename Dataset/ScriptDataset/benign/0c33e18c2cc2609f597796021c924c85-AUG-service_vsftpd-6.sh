  mkdir -p $MNT_DIR/anonymous
  echo "anonymous::505:505:file_guest:$MNT_DIR/anonymous:/bin/sh" >> $POSIX_PASS_FILE
  sed -i "s/file_guest:x:1004:/file_guest:x:1004:anonymous,/g" $POSIX_GROUP_FILE
  mount_anon_folders
