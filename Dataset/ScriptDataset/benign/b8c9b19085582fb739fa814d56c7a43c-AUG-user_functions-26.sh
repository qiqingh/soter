   MODEL_NAME=`syscfg get device::model_base`
   if [ -z "$MODEL_NAME" ] ; then
        MODEL_NAME=`syscfg get device::modelNumber`
	MODEL_NAME=${MODEL_NAME%-*}
   fi
    HW_REVISION=`syscfg get device::hw_revision`
    remove_user_passwords "$1"
    posix_pass=`cryptpw -a md5 "$2"`
    ugroup=$(get_user_group "$1")
      if [ "$ugroup" == "admin" ] ; then
        echo "$1:x:$3:0:File User,,,:$MNT_DIR/admin_mnt:/bin/sh" >> $POSIX_PASS_FILE
      elif [ "$ugroup" == "guest" ] ; then
        echo "$1:x:$3:$3:File User,,,:$MNT_DIR/guest_mnt:/bin/sh" >> $POSIX_PASS_FILE
      else
        if [ "$4" == "file_admin" ] ; then
          echo "$1:x:$3:0:File User,,,:$MNT_DIR/$ugroup:/bin/sh" >> $POSIX_PASS_FILE
        else
          echo "$1:x:$3:$3:File User,,,:$MNT_DIR/$ugroup:/bin/sh" >> $POSIX_PASS_FILE
        fi
      fi
    
    echo "$1:$posix_pass:15070:0:99999:7:::" >> $POSIX_SHAD_FILE
    
    UID=$3
    PASS=$2
    sed -i "/^$UID:.*/d" $USER_PASSFILE
    echo "$3:$2" >> $USER_PASSFILE
