  umount_ftp_shares
  unmount_anon_folders
  remove_group_mount_points
  rmmod nf_nat_ftp
  rmmod nf_conntrack_ftp
  insmod /lib/modules/`uname -r`/nf_conntrack_ftp.ko
  insmod /lib/modules/`uname -r`/nf_nat_ftp.ko
