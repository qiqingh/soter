#!/bin/sh

#------------------------------------------------------------------
# © 2013 Belkin International, Inc. and/or its affiliates. All rights reserved.
#------------------------------------------------------------------
source /etc/init.d/syscfg_api.sh
source /etc/init.d/nvram_api.sh

# This is a utility needed to run on Pinnacle to setup the requireed
# nvram settings if it not there. It is critical for all BCM
# library to work
# This file is unit for each product lemans/esprit/honda/f70/etc...
ET0_MAC="$1"

display_usage()
if [ -z "$ET0_MAC" ]; then
	display_usage
else
	processing
	VALIDATED=`syscfg get wl_params_validated`
	if [ "true" != "$VALIDATED" ]; then
		default_wifi_network
		syscfg_set wl_params_validated true
	fi
	syscfg_commit
	nvram_commit
fi

exit 0
