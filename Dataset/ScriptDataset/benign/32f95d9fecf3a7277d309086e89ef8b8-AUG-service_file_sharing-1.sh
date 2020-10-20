  S_NAME=`syscfg get smb_server_name`
  if [ "$S_NAME" == "" ] || [ "$S_NAME" == "(none)" ]; then
    if [ `hostname` != "(none)" ] ; then
    syscfg set smb_server_name `hostname`
    fi
  fi
  S_NAME=`syscfg get ftp_server_name`
  if [ "$S_NAME" == "" ] || [ "$S_NAME" == "(none)" ]; then
    if [ `hostname` != "(none)" ] ; then
    syscfg set ftp_server_name `hostname`
    fi
  fi
  S_NAME=`syscfg get media_server_name`
  if [ "$S_NAME" == "" ] || [ "$S_NAME" == "(none)" ]; then
    if [ `hostname` != "(none)" ] ; then
    syscfg set media_server_name `hostname`
    fi
  fi
