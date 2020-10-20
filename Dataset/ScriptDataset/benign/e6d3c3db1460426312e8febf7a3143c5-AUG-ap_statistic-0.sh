#!/bin/sh
echo [$0] ... > /dev/console
statistic &> /dev/console

xmldbc -t "traffic:300:sh /etc/templates/ap_statistic.sh"