#!/bin/sh
#rtlioc enlan 0
service PHYINF.WIFI stop

xmldbc -k "DOWNLINK_RESTART"
#xmldbc -t "DOWNLINK_RESTART:10:rtlioc enlan 1; service PHYINF.WIFI start"
xmldbc -t "DOWNLINK_RESTART:10:service PHYINF.WIFI start"
exit 0
