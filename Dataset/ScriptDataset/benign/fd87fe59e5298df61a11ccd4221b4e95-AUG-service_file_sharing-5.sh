    if [ -f /bin/smp.sh ] ; then
        echo "${SERVICE_NAME}, smp wifi"
        /bin/smp.sh wifi 2>/dev/null
        rmmod nf_sc 2>/dev/null
    fi
  if [ -f "/etc/init.d/service_mediaserver.sh" ] ; then
    if [ "$EVENT_NAME" != "dns-restart" ] ; then
        /etc/init.d/service_mediaserver.sh mediaserver-stop
    fi
  fi
  /etc/init.d/service_vsftpd.sh vsftpd-stop
  /etc/init.d/service_smbd.sh smbd-stop
  sysevent set file_sharing-status stopped
  /etc/init.d/share_parser.sh
