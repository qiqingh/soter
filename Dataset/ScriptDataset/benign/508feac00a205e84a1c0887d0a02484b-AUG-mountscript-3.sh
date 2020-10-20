  numPartitions=$2
  partitionCnt=$1
  DRIVE_COUNT=0;
  DEVS=`ls /dev/ | grep -r "sd[a-z]" | uniq`
  if [ "$DEVS" != "" ] ; then
  for d in $DEVS
  do
    if [ -d "/mnt/$d" ] ; then
      mnt_pt_check=`mount | grep /tmp/mnt/$d | wc -l`
      if [ $mnt_pt_check -gt 0 ] ; then
        DRIVE_COUNT=`expr $DRIVE_COUNT + 1`
      fi
    fi
  done
  fi
  echo "DRIVE_COUNT = $DRIVE_COUNT, numPartitions=$numPartitions, partitionCnt=$partitionCnt" > /dev/console
  if [ "$numPartitions" == "$partitionCnt" ]; then
    dc=`sysevent get no_usb_drives`
    if [ ! "$dc" ] ; then
			dc="0"
    fi
    echo "setting current drive count from $dc to $DRIVE_COUNT" >> /dev/console
    sysevent set no_usb_drives $DRIVE_COUNT
    sysevent set mount_usb_drives "finished"
    sysevent set usb_no_partitions_$devblock ""
    sysevent set usb_curr_partition_cnt_$devblock ""
    usb_mount_drives=`ls "/tmp/mnt/" | grep "$devblock" | wc -l`
    sysevent set usb_mount_cnt_$devblock $usb_mount_drives
  else
		if [ "$numPartitions" == "0" ] ; then
			if [ "$partitionCnt" != "0" ] ; then
			echo "partition count mismatch $numPartitions:$partitionCnt" >> /dev/console
			echo "trying to mount anyway" >> /dev/console
			dc=`sysevent get no_usb_drives`
			if [ ! "$dc" ] ; then
				dc="0"
			fi
			echo "setting current drive count from $dc to $DRIVE_COUNT" >> /dev/console
			sysevent set no_usb_drives $DRIVE_COUNT
			sysevent set mount_usb_drives "finished"
			sysevent set usb_no_partitions_$devblock ""
			sysevent set usb_curr_partition_cnt_$devblock ""
			usb_mount_drives=`ls "/tmp/mnt/" | grep "$devblock" | wc -l`
			sysevent set usb_mount_cnt_$devblock $usb_mount_drives
			fi
		fi
  fi
