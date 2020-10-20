  if [ ! -d "/tmp/mnt" ] ; then
    mkdir -p /tmp/mnt
  fi
  create_user_group_entries
  sync_file_users
