  if [ -d "/mnt" ] ; then
  SMB_INFILES=`find /mnt/ -maxdepth 2 -name ".smb_share.nfo"`
  FTP_INFILES=`find /mnt/ -maxdepth 2 -name ".ftp_share.nfo"`
  MED_INFILES=`find /mnt/ -maxdepth 2 -name ".med_share.nfo"`
  fi
