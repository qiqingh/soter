#!/bin/bash

cli_path=$(dirname $(readlink -f ${0}))/

#usb_path=/media/realroot/
led_path=/sys/class/leds/pca963x:
gpio_path=/sys/class/gpio/

#tmp_path=/var/cy_cli/
#tmp_prefix=${tmp_path}cli-
#tmp_wifi_scan=${tmp_prefix}wifi_scan
#tmp_bt_init=/tmp/bt_init
#tmp_rtc_time=${tmp_prefix}rtc_time

printk=/proc/sys/kernel/printk
raw_printk=""


if [ "$(echo ${0} | awk -F'/' '{print $NF}')" = "$(echo ${BASH_SOURCE[0]} | awk -F'/' '{print $NF}')" ] && [ "$(type -t ${1})" = "function" ]; then
    ${1} "${@:2}"
fi
