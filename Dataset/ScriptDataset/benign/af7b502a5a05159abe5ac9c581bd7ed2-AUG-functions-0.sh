#!/bin/sh
# Copyright (C) 2006-2014 OpenWrt.org
# Copyright (C) 2006 Fokus Fraunhofer <carsten.tittel@fokus.fraunhofer.de>
# Copyright (C) 2010 Vertical Communications


# newline
N="
"

_C=0
NO_EXPORT=1
LOAD_STATE=1
LIST_SEP=" "


# config_get <variable> <section> <option> [<default>]
# config_get <section> <option>
# config_get_bool <variable> <section> <option> [<default>]
[ -z "$IPKG_INSTROOT" -a -f /lib/config/uci.sh ] && . /lib/config/uci.sh
