#!/bin/sh

#------------------------------------------------------------------
# © 2013 Belkin International, Inc. and/or its affiliates. All rights reserved.
#------------------------------------------------------------------

# This is a utility needed to run on Carrera to setup the requireed
# nvram settings if it not there. It is critical for all BCM
# libraries to work
# This file is unit for carrera
ET0_MAC="$1"

display_usage()
if [ -z "$ET0_MAC" ]; then
	display_usage
else
	VALIDATED=`syscfg get wl_params_validated`
	if [ "true" != "$VALIDATED" ]; then
		processing

		#commented out to fix RAINIER-8646: SSID and wireless password reset to default after FW update from RainCap_AC to ChuckNorris
		#default_wifi_network

		syscfg set wl_params_validated true
	fi
fi

exit 0
