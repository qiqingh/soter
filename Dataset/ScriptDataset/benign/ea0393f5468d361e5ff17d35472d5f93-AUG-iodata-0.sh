#
# Copyright (C) 2019 OpenWrt.org
#

. /lib/functions.sh

# I-O DATA devices manufactured by MSTC (MitraStar Technology Corp.)
# have two important flags:
# - bootnum: switch between two os images
#     use 1st image in OpenWrt
# - debugflag: enable/disable debug
#     users can interrupt Z-Loader for recovering the device if enabled
