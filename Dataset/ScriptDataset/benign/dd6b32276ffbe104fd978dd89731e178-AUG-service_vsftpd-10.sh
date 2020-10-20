  echo "remove_mount_points:" >> $TMP_LOG
  GCOUNT=`syscfg get group_count`
  for i in `seq 1 $GCOUNT`
  do
    GNAME=`syscfg get group_${i}_name`
      if [ "$GNAME" != "admin" ] && [ "$GNAME" != "guest" ] ; then
      echo "removing mount point $i - $MNT_DIR/$GNAME" >> $TMP_LOG
      around=`mount | grep "$MNT_DIR/$GNAME"`
      if [ "$around" != "" ] ; then
        echo "disk not unmounted : $around"  >> $TMP_LOG
      else 
        echo "removing mount point $i - $MNT_DIR/$GNAME" >> $TMP_LOG
        if [ "$GNAME" != "admin" ] && [ "$GNAME" != "guest" ] ; then
          rmdir "$MNT_DIR/$GNAME"
        fi
      fi
    fi
  done
