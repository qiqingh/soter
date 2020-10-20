  /etc/init.d/service_mediaserver.sh mediaserver-stop
  /etc/init.d/service_vsftpd.sh vsftpd-stop
  /etc/init.d/service_smbd.sh smbd-stop
  sysevent set file_sharing-status stopped
  /etc/init.d/share_parser.sh
