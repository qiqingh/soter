#!/bin/sh

# wlX -> 0, 0.1, etc...
# br0, br1...br3
if [ "$2" = "" ]; then
	exit 1
fi

CRYPTO=$(nvram get wl${1}_crypto)
