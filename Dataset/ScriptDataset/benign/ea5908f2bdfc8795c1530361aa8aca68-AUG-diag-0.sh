#!/bin/sh
# Copyright (C) 2010-2015 OpenWrt.org

. /lib/functions/leds.sh
. /lib/functions/lantiq.sh

boot="$(lantiq_get_dt_led boot)"
failsafe="$(lantiq_get_dt_led failsafe)"
running="$(lantiq_get_dt_led running)"

