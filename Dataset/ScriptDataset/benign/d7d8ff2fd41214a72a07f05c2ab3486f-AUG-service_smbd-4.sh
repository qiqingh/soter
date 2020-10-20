  CHECK_DRIVES=$(get_all_media_drives)
  for D in $CHECK_DRIVES
  do
    if [ -f "/mnt/$D/.smb_share.nfo" ] ; then
      ulog smbd "found SMB share config on drive $D"
      CFG=`cat "/mnt/$D/.smb_share.nfo" | sed "s/+DRIVE+/$D/g"`
      echo "$CFG"
      /etc/init.d/share_parser.sh
    else 
      ulog smbd "no SMB share config found on drive $D"
    fi
  done
