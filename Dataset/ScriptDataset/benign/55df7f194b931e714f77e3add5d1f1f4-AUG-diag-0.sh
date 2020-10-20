#!/bin/sh
# Copyright (C) 2016 Henryk Heisig hyniu@o2.pl

. /lib/functions/leds.sh
. /lib/ipq806x.sh

boot="$(ipq806x_get_dt_led boot)"
failsafe="$(ipq806x_get_dt_led failsafe)"
running="$(ipq806x_get_dt_led running)"
upgrade="$(ipq806x_get_dt_led upgrade)"

