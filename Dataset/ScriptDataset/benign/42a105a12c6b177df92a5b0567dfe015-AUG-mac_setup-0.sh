#!/bin/sh

#------------------------------------------------------------------
# © 2013 Belkin International, Inc. and/or its affiliates. All rights reserved.
#------------------------------------------------------------------
source /etc/init.d/syscfg_api.sh
source /etc/init.d/nvram_api.sh

# This is a utility needed to run on r8v2 to setup the requireed
# nvram settings if it not there. It is critical for all BCM
# libraries to work
# This file is unit for r8v2
ET0_MAC="$1"

display_usage()
if [ -z "$ET0_MAC" ]; then
	display_usage
else
	processing
	syscfg commit
fi

exit 0
