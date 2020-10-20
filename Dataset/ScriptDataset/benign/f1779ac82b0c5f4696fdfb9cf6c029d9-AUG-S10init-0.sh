#!/bin/sh
mount -t proc none /proc
mount -t ramfs ramfs /var
mount -t sysfs sysfs /sys
echo 7 > /proc/sys/kernel/printk
echo 1 > /proc/sys/vm/panic_on_oom
echo 1 > /proc/sys/vm/drop_caches
#traveller add for TCP Off-Path Vulnerability CVE-2016-5696
echo 1000 > /proc/sys/net/ipv4/tcp_challenge_ack_limit
