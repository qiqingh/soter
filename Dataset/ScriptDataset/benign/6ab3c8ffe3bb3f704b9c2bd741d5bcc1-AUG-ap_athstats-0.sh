#!/bin/sh
echo [$0] ... > /dev/console
athstats -i wifi0 >/dev/console
athstats -i wifi0 1 > /dev/console