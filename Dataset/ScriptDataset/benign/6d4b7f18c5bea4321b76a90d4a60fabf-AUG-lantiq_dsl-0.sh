#!/bin/sh /etc/rc.common
# Copyright (C) 2012-2014 OpenWrt.org

if [ "$( which vdsl_cpe_control )" ]; then
	XDSL_CTRL=vdsl_cpe_control
else
	XDSL_CTRL=dsl_cpe_control
fi

#
# Basic functions to send CLI commands to the vdsl_cpe_control daemon
#
#
# Simple divide by 10 routine to cope with one decimal place
#
# Take a number and convert to k or meg
#
#
# convert vendorid into human readable form
#
#
# Read the data rates for both directions
#
#
# Chipset
#
#
# Vendor information
#
#
# XTSE capabilities
#
#
# Power Management Mode
#
#
# Latency type (interleave delay)
#
#
# Errors
#
#
# Work out how long the line has been up
#
#
# Get noise and attenuation figures
#
#
# Is the line up? Or what state is it in?
#
#
# Which profile is used?
#
