  sed -i "/anonymous:.*$/d" $POSIX_PASS_FILE
  sed -i "/anonymous:.*$/d" $POSIX_SHAD_FILE
  sed -i "s/anonymous,//g" $POSIX_GROUP_FILE
  unmount_anon_folders
  rmdir $MNT_DIR/anonymous
