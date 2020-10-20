  if [ "$1" ] ; then
    bl=$(check_user_blacklist "$1")
    if [ ! "$bl" ] ; then
      sed -i "/^$1:.*/d" $POSIX_PASS_FILE
      sed -i "/^$1:.*/d" $POSIX_SHAD_FILE
      sed -i "/^$1:.*/d" $SAMBA_PASS_FILE
    fi
  fi
