   if [ $TMS_ENABLED -gt 0 ]; then
      config_cgroup
      wait_till_end_state ${SERVICE_NAME}
      
      DEFDRIVE=$(get_first_media_drive)
      
      BASEDIR="/mnt"
      DBDIR="/mnt/$DEFDRIVE"
      APPDATA="/mnt/$DEFDRIVE/.tmp"
      TMS_SHDEFAULT="/mnt/$DEFDRIVE"
     
      SHARECNT=`syscfg get MedFolderCount`
      if [ $SHARECNT -lt 1 ] ; then
        
        drive_count=`sysevent get no_usb_drives`
        if [ "$drive_count" == "" ] || [ "$drive_count" == "0" ] ; then
            echo "no storage drives attached"
            exit
        fi
        
        OTHERDRIVES=$(get_all_media_drives)
        contentdir=""
        for hdd in $OTHERDRIVES
        do
       	if [ "$contentdir" == "" ] ; then
            contentdir="+A|/mnt/$hdd"
	else
            contentdir="+A|/mnt/$hdd,$contentdir"
	fi
        done
        if [ "$contentdir" == "" ] ; then
          contentdir="+A|/"
        fi
      else
        contentdir=""
        for ct in `seq 1 $SHARECNT`
        do
          NAMESPACE="med_${ct}"
          NAME=`syscfg get $NAMESPACE name`
          FOLDER=`syscfg get $NAMESPACE folder`
          DRIVE=`syscfg get $NAMESPACE drive`
          READONLY=`syscfg get $NAMESPACE readonly`
          if [ $ct -eq 1 ] ; then
            contentdir="+A|/mnt/$DRIVE$FOLDER"
          else
            contentdir="+A|/mnt/$DRIVE$FOLDER,$contentdir"
          fi
          echo "" >> $LOG_FILE
          echo "media share $ct" >> $LOG_FILE
          echo " Drive: $DRIVE" >> $LOG_FILE
          echo "FOLDER: $FOLDER" >> $LOG_FILE
        done
      fi
     
     STATUS=`sysevent get ${SERVICE_NAME}-status`
     if [ "started" != "$STATUS" ] ; then
        sysevent set ${SERVICE_NAME}-errinfo 
        sysevent set ${SERVICE_NAME}-status starting
        
        echo "Starting ${SERVICE_NAME}"
        cp /etc/mediaserver.ini $CFGFILE
        sed -i "s%-BASEDIR-%%g" $CFGFILE
        sed -i "s%=/mnt/%=%g" $CFGFILE
        sed -i "s%-CONTENTDIR-%$contentdir%g" $CFGFILE
        sed -i "s%-ENABLEWEB-%$TMS_WEBENA%g" $CFGFILE
        sed -i "s%-SERVERNAME-%$TMS_NAME%g" $CFGFILE
        sed -i "s%-SCANTIME-%$TMS_SCANTIME%g" $CFGFILE
  ulimit -v 60000
	ln -sf $WORKDIR1/mediawatcher.sh /etc/cron/cron.daily/                                      
        
	bridge_mode=`syscfg get bridge_mode`					
	if [ "$bridge_mode" = 0 ]; then						
		serv_loc_addr=`syscfg get lan_ipaddr`				
	else									
		serv_loc_addr=`sysevent get ipv4_wan_ipaddr`			
	fi						
        export TZ=`sysevent get TZ`       
        "$TWONKYSRV" -D -contentbase "/" -contentdir "$contentdir" -cachedir "$DBDIR/cache" -dbdir "$DBDIR/.tmp" -appdata "${APPDATA}"   \
        -inifile $CFGFILE -httpport $TMS_PORT -ignoredir ".tmp" -enableweb $TMS_WEBENA -rmautoshare 0 -friendlyname "$TMS_NAME" \
        -scantime $TMS_SCANTIME -uploadenabled 0 -rmautoshare 0 -rmhomedrive "/mnt" -maxitems $TMS_MAXITEMS -ip "$serv_loc_addr" \
	-v $TMS_V -vlevel $TMS_VLEVEL \
	-followlinks 0 \
	-disablefrontends 8 \
        -cachemaxsize 2048 -stack_size 320000 -logfile "/mnt/$DEFDRIVE/.tmp/twonky.log"
        check_err $? "Couldnt handle start"
        sysevent set ${SERVICE_NAME}-status started
        if [ -f "/mnt/$DEFDRIVE/.tmp/db.info" ] ; then
          LAST_SCAN_TIME=`cat /mnt/$DEFDRIVE/.tmp/db.info | head -n 1 | sed 's/t://g'`
        else
          LAST_SCAN_TIME="Not Available"
        fi
        syscfg set last_scan_time_file "/mnt/$DEFDRIVE/.tmp/db.info"
        syscfg set last_scan_time "$LAST_SCAN_TIME"
     fi
   else
      echo "${SERVICE_NAME} disabled in configuration"
      echo "please use:"
      echo "syscfg set media_server_enabled 1"
      echo "to enable the server"
   fi
