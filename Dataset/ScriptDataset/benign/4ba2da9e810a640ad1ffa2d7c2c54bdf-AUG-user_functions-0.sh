#!/bin/sh
POSIX_PASS_FILE="/tmp/etc/.root/passwd"
POSIX_SHAD_FILE="/tmp/etc/.root/shadow"
POSIX_GROUP_FILE="/tmp/etc/.root/group"
SAMBA_PASS_FILE="/tmp/samba/smbpasswd"
USER_PASS_FILE=`syscfg get user_auth_file`
MNT_DIR="/tmp/ftp"
UTMP_LOG="/tmp/user_config.log"
echo "" > $UTMP_LOG
FILE_ADMIN_GROUP_NAME="file_admin"
DEFAULT_GROUP=$FILE_ADMIN_GROUP_NAME
USER_BLACKLIST="root nobody sshd quagga firewall"
MIN_USER_ID=1010
USER_PASSENC=$(get_pw_file_enc)
USER_COUNT=$(get_user_count)
