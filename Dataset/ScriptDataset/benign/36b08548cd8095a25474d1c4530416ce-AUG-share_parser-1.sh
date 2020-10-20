  if [ -d "/mnt" ] ; then
  SMB_INFILES=`find /mnt/sd*/ -maxdepth 1 -name ".smb_share.nfo"`
  FTP_INFILES=`find /mnt/sd*/ -maxdepth 1 -name ".ftp_share.nfo"`
  MED_INFILES=`find /mnt/sd*/ -maxdepth 1 -name ".med_share.nfo"`
  fi
