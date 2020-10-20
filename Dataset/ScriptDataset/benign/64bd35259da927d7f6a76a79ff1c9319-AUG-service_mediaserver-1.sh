  TMS_ENABLED=`syscfg get media_server_enabled`
  TMS_NAME=`syscfg get media_server_name`
  if [ "$TMS_NAME" == "" ] ; then
    TMS_NAME=`hostname`
  fi
  TMS_PORT=`syscfg get media_server_port`
  TMS_SCANTIME=`syscfg get media_server_scan_time`
  TMS_SHDEFAULT=`syscfg get media_server_default_share`
  TMS_WEBENA="2"
  TMS_CONTENTDIR=`syscfg get media_server_contentdir`
  TMS_V=`syscfg get media_server_v`
  if [ X"$TMS_V" == X"" ]; then 
	TMS_V=0
  fi
  TMS_VLEVEL=`syscfg get media_server_vlevel`
  if [ X"$TMS_VLEVEL" == X"" ]; then 
	TMS_VLEVEL=0
  fi
  TMS_MAXITEMS=`syscfg get media_server_maxitems`
  if [ X"$TMS_MAXITEMS" == X"" ]; then 
	TMS_MAXITEMS=8000
  fi
  
  if [ -e "/tmp/TwonkyMediaServer-log.txt" ] ; then
      rm -f /tmp/TwonkyMediaServer-log.txt
  fi
  ln -sf /dev/null /tmp/TwonkyMediaServer-log.txt
  
  if [ ! -d "$CFGDIR" ]; then
    mkdir -p "$CFGDIR"
  fi
