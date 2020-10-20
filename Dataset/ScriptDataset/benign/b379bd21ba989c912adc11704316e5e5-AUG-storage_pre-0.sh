#!/bin/sh

mkdir -m 777 /tmp/var/spool;

## shares 
mount -t tmpfs -o size=40m none /foreign_shares
chmod 755 /foreign_shares;

## Tuxera 
mkdir -p -m 777 /var/lib/tsmb/run
touch /var/lib/tsmb/users_db.txt

## vsftpd
mkdir -m 0755 -p /var/run/vsftpd

## /var/lib/nfs
mkdir -m 777 /tmp/var/lib;
mkdir -m 777 /tmp/var/lib/nfs;
touch /tmp/var/lib/nfs/xtab;
chmod 644 /tmp/var/lib/nfs/xtab;
touch /tmp/var/lib/nfs/etab;
chmod 644 /tmp/var/lib/nfs/etab;
touch /tmp/var/lib/nfs/rmtab;
chmod 644 /tmp/var/lib/nfs/rmtab;
mkdir -m 700 /tmp/var/lib/nfs/sm;
mkdir -m 700 /tmp/var/lib/nfs/sm.bak;
touch /tmp/var/lib/nfs/state;
chmod go-rwx /tmp/var/lib/nfs/state;

## /tmp/samba 
mkdir -m 777 /tmp/samba;
mkdir -m 777 /tmp/samba/lib;
mkdir -m 777 /tmp/samba/var;
mkdir -m 777 /tmp/samba/var/locks;
mkdir -m 777 /tmp/samba/private;

##  /tmp/raid 
mkdir -m 777 /tmp/raid;

mkdir -m 777 /tmp/rc_notification;
mkdir -m 777 /tmp/rc_action_incomplete;
touch /tmp/disk_updating_lock;
chmod 644 /tmp/disk_updating_lock;
touch /tmp/file_variable_updating_lock;
chmod 644 /tmp/file_variable_updating_lock;
mkdir -m 777 /tmp/shares_going;
mkdir -m 777 /tmp/foreign_shares_going;
mkdir -m 777 /tmp/pools_going;
mkdir -m 777 /tmp/disks_going;
mkdir -m 777 /tmp/reserved_foreign_share_names;
mkdir -m 777 /tmp/share_name_mappings;
mkdir -m 777 /tmp/foreign_share_info;
mkdir -m 777 /tmp/disk_names;
