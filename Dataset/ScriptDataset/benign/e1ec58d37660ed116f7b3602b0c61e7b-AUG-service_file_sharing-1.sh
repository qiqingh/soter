  PASS_FILE=`syscfg get user_auth_file`
  if [ ! -f "$PASS_FILE" ] ; then
    PASS=`syscfg get http_admin_password_initial`
    if [ -z "$PASS" ] ; then
    	PASS=admin
    fi
    echo "1000:$PASS" > $PASS_FILE
    echo "1001:guest" >> $PASS_FILE
  fi
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
  
