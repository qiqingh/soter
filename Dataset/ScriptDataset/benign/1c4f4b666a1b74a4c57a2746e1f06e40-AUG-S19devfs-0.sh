#!/bin/sh
[ -d /dev/mtdblock ] || mkdir /dev/mtdblock
mknod /dev/mtdblock/0 b   31  0
mknod /dev/mtdblock/1 b   31  1
mknod /dev/mtdblock/2 b   31  2
mknod /dev/mtdblock/3 b   31  3
mknod /dev/mtdblock/4 b   31  4
mknod /dev/mtdblock/5 b   31  5
mknod /dev/mtdblock/6 b   31  6
