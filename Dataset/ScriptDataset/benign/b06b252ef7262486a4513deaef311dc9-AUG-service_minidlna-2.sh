  wait_till_end_state ${SERVICE_NAME}
  drive_count=`sysevent get no_usb_drives`
  if [ "$drive_count" == "" ] || [ "$drive_count" == "0" ] ; then
	echo "no storage drive attached" >> $LOG_FILE
	return
  else
  config_cgroup
  wait_till_end_state usb_mountscript
  wait_till_end_state vsftpd
  name_server="`syscfg get MediaServer::name`"
  if [ "$name_server" == "" ] ; then
	name_server=`hostname`
  fi
  minidlna_port="`syscfg get MediaServer::port`"
  if [ "$minidlna_port" == "" ] ; then
	minidlna_port=9999
  fi
  if [ "`sysevent get ${SERVICE_NAME}-delay_start`" == "" ] ; then
		sleep 15
		sysevent set ${SERVICE_NAME}-delay_start done
  fi
	service_init
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "started" != "$STATUS" ] ; then
		sysevent set ${SERVICE_NAME}-errinfo 
		sysevent set ${SERVICE_NAME}-status starting
        med_folder_count=`syscfg get MedFolderCount`
        if [ "$med_folder_count" == "" ] || [ "$med_folder_count" == "0" ] ; then
	    DEVS=`ls /dev/ | grep -r "sd[a-z]" | uniq`
	    contentdir=""
	    if [ "$DEVS" != "" ] ; then
	        	for d in $DEVS
	        	do
				if [ -d "/mnt/$d" ] ; then
	        			contentdir="media_dir=AVP,/mnt/$d $contentdir"
	        		fi
	        	done
	    fi
        else
            drive=""
            folder=""
            for num in `seq 1 $med_folder_count`
            do
            drive=`syscfg get med_$num::drive`
            folder=`syscfg get med_$num::folder`
               if [ -d "/mnt/$drive$folder" ] ; then
                  contentdir="media_dir=AVP,/mnt/$drive$folder $contentdir"
               fi
            done
        fi
		echo "Starting ${SERVICE_NAME}"
media_dir=`echo $contentdir | sed "s/media_dir=/\nmedia_dir=/g"`
echo "port=$minidlna_port
network_interface=br0
user=root
$media_dir
friendly_name=$name_server
album_art_names=Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg/AlbumArt.jpg/albumart.jpg/Album.jpg/album.jpg/Folder
inotify=yes
enable_tivo=no
strict_dlna=yes
notify_interval=900
serial=12345678
model_number=1
" > $CFGFILE
		/sbin/minidlnad -R -f $CFGFILE &
		check_err $? "Couldnt handle start"
		sysevent set ${SERVICE_NAME}-status started
	fi
  fi
