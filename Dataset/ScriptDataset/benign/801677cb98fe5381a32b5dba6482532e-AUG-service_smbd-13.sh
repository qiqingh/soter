  echo "service_smbd.sh: service_init"
  echo "umount_samba_shares:"
  umount_samba_shares
  echo "mount_samba_shares:"
  mount_samba_shares
  echo "sync_file_users:"
  sync_file_users
  echo "create_samba_conf:"
  create_samba_conf
  echo "create_samba_passwd_file"
  create_samba_passwd_file
