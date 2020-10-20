  ulog sharing "umount unused devices"
  mount | grep "sd[a-z].*" | sed -r "s/.* on (.*) type .*/\1/g" | sed "s|.040(deleted)||g" | while read file;
  do
    ulog sharing "umount unused devices: unmounting $file"
    dev=`echo $file | awk -F '/' '{print $NF}'`
    tmp_dev="/tmp/$dev"
    ulog sharing "umount unused devices: file=$file, tmp_dev=$tmp_dev"
    if [ "$file" != "$tmp_dev" ] ; then
      if [ -d $tmp_dev ] ; then
        ulog sharing "umount unused devices: Do not umount $file"
      else
        ulog sharing "umount unused devices: umount $file"
        umount "$file"
        rc=$?
        sync
        if [ "$rc" != "0" ] ; then 
          ulog sharing "umount unused devices: ERROR unmount $file"
          umount "$file"
        fi
        ulog sharing "umount unused devices: rmdir $file"
        rmdir "$file"
        if [ -d "$file" ] ; then
          if [ -z "$(ls -A $file)" ] ; then
            ulog sharing "umount unused devices: Found empty dir = $file and remove dir"
            rmdir "$file"
          fi
        fi        
      fi
    fi
  done
