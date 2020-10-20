  echo "create_mount_points:" >> $TMP_LOG
  if [ ! -d "$MNT_DIR_ADMIN" ] ; then
    mkdir -p "$MNT_DIR_ADMIN"
    chmod 755 "$MNT_DIR_ADMIN"
  fi
  if [ ! -d "$MNT_DIR_GUEST" ] ; then
    mkdir -p "$MNT_DIR_GUEST"
    chmod 755 "$MNT_DIR_GUEST"
  fi
  GCOUNT=`syscfg get group_count`
  
  echo "creating mount points for $GCOUNT groups" >> $TMP_LOG
  for i in `seq 1 $GCOUNT`
  do
    GNAME=`syscfg get group_${i}_name`
    GPERM=`syscfg get group_${i}_perms`
    
    if [ "$GNAME" ] && [ "$GPERM" ] ; then
      if [ "$GPERM" == "file_admin" ] ; then
        if [ "$GNAME" != "admin" ] ; then
          if [ ! -d "$MNT_DIR/$GNAME" ] ; then
            echo "creating mount point $i - $MNT_DIR/$GNAME (admin group)" >> $TMP_LOG
            mkdir "$MNT_DIR/$GNAME"
            chmod 755 "$MNT_DIR/$GNAME"
          else
            echo "could not find path $MNT_DIR/$GNAME" >> $TMP_LOG
          fi
        fi
      elif [ "$GPERM" == "file_guest" ] ; then
        if [ "$GNAME" != "guest" ] ; then
          if [ ! -d "$MNT_DIR/$GNAME" ] ; then
            echo "creating mount point $i - $MNT_DIR/$GNAME (guest group)" >> $TMP_LOG
            mkdir "$MNT_DIR/$GNAME"
            chmod 755 "$MNT_DIR/$GNAME"
          else
            echo "could not find path $MNT_DIR/$GNAME" >> $TMP_LOG
          fi
        fi
      fi
    fi
  done
