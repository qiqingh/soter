#!/bin/sh
# Copyright (C) 2007-2013 OpenWrt.org

# This setup gives us 4.5 distinguishable states:
#
# (1-LED) Solid OFF:    Bootloader running, or kernel hung (timer task stalled)
# (1-LED) Solid ON:     Kernel hung (timer task stalled)
# (2-LED) Solid RED:    Bootloader running, or kernel hung (timer task stalled)
# (2-LED) Solid YELLOW: Kernel hung (timer task stalled)
# 5Hz blink:            preinit
# 10Hz blink:           failsafe
# (1-LED) Heartbeat:    normal operation
# (2-LED) Solid GREEN:  normal operation

. /lib/functions/leds.sh

