#!/bin/sh
# Copyright (C) 2016 Henryk Heisig hyniu@o2.pl

. /lib/functions/leds.sh

boot="$(get_dt_led boot)"
failsafe="$(get_dt_led failsafe)"
running="$(get_dt_led running)"
upgrade="$(get_dt_led upgrade)"

