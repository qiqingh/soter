#!/bin/sh

[ $1 = "start" ] && start $2
[ $1 = "stop" ] && stop
[ $1 = "restart" ] && restart $2
