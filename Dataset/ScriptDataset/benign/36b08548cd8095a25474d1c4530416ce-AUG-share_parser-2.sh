  INDEXS=`cat $1 | cut -d'|' -f1 | sed "s/{index://g" | tr -d '"'`
  NAMES=`cat $1 | cut -d'|' -f2 | sed "s/name:/+/g" | tr -d '"'`
  DRIVES=`cat $1 | cut -d'|' -f3 | sed "s/drive://g" | tr -d '"'`
  FOLDERS=`cat $1 | cut -d'|' -f5 | sed "s/folder:/+/g" | tr -d '"'`
  READONLY=`cat $1 | cut -d'|' -f6 | sed "s/readonly://g"`
  GROUPS=`cat $1 | cut -d'|' -f7 | sed "s/groups://g" | tr -d '"' | tr -d '}'`
  
  DRIVE_SHARE_COUNT=`cat $1 | grep "name:" | wc -l`
  echo `seq 1 $DRIVE_SHARE_COUNT` >> $LOG_FILE
  echo "NAMES = $NAMES" >> $LOG_FILE
  echo "FOLDERS = $FOLDERS" >> $LOG_FILE
  for num in `seq 1 $DRIVE_SHARE_COUNT`
  do
    echo "$idx===========================================" >> $LOG_FILE
    offset=`expr $num + 1`
    index=`echo $INDEXS | cut -d' ' -f${num}`
    name=`echo "$NAMES" | awk '{printf $0}' | cut -d'+' -f$offset | sed -e 's/ $//g'`
    
    drive=`echo -n "$1" | cut -d'/' -f3`
    folder=`echo "$FOLDERS" | tr -d '\n' | cut -d'+' -f$offset | sed -e 's/ $//g'`
    readonly=`echo $READONLY | cut -d' ' -f${num}`
    groups=`echo $GROUPS | cut -d' ' -f${num}`
    
    if [ "$2" == "smb" ] 
    then
      echo "num=$num, sidx=$sidx, scc=$smb_cur_count" >> $LOG_FILE
      sidx=`expr $num + $TOTAL_SMB_COUNT`
      echo "configuring smb shares $sidx" >> $LOG_FILE     
      echo "smb current count $smb_cur_count" >> $LOG_FILE
      idx=$sidx
    fi
    if [ "$2" == "ftp" ] ; then
      echo "num=$num, fidx=$fidx, fcc=$ftp_cur_count" >> $LOG_FILE
      fidx=`expr $num + $TOTAL_FTP_COUNT`
      echo "configuring ftp shares $fidx" >> $LOG_FILE
      echo "ftp current count $ftp_cur_count" >> $LOG_FILE
      idx=$fidx
    fi
    if [ "$2" == "med" ] ; then
     echo "num=$num, midx=$midx, mcc=$med_cur_count" >> $LOG_FILE
      midx=`expr $num + $TOTAL_MED_COUNT`
      echo "configuring med shares $midx" >> $LOG_FILE
      echo "med current count $med_cur_count" >> $LOG_FILE
      idx=$midx
    fi
   echo "" >> $LOG_FILE
   syscfg set $2_${idx} name "$name"
   syscfg set $2_${idx} drive $drive
   syscfg set $2_${idx} folder "$folder"
   syscfg set $2_${idx} readonly $readonly
   syscfg set $2_${idx} groups "$groups"
  done
  if [ "$num" == "" ] ; then
    num="0"
  fi
  DRIVE_SHARE_COUNT=`expr $num`
  
  echo "disk_shares_to_syscfg $1 $2 - end" >> $LOG_FILE
  echo "$DRIVE_SHARE_COUNT"
