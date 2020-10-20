#.Distributed under the terms of the GNU General Public License (GPL) version 2.0
#.2014-2015 Christian Schoenebeck <christian dot schoenebeck at gmail dot com>
[ $use_https -eq 0 ] && write_log 14 "Cloudflare only support updates via Secure HTTP (HTTPS). Please correct configuration!"
[ -z "$username" ] && write_log 14 "Service section not configured correctly! Missing 'username'"
[ -z "$password" ] && write_log 14 "Service section not configured correctly! Missing 'password'"
local __RECID __URL __KEY __KEYS __FOUND __SUBDOM __DOMAIN __TLD
split_FQDN $domain __TLD __DOMAIN __SUBDOM
[ $? -ne 0 -o -z "$__DOMAIN" ] && \
	write_log 14 "Wrong Host/Domain configuration ($domain). Please correct configuration!"
__DOMAIN="$__DOMAIN.$__TLD"
. /usr/share/libubox/jshn.sh
__URL="${__URL}?a=rec_edit"
__URL="${__URL}&tkn=$password"
__URL="${__URL}&id=$__RECID"
__URL="${__URL}&email=$username"
__URL="${__URL}&z=$__DOMAIN"
[ $use_ipv6 -eq 0 ] && __URL="${__URL}&type=A"
[ $use_ipv6 -eq 1 ] && __URL="${__URL}&type=AAAA"
[ -n "$__SUBDOM" ] && __URL="${__URL}&name=$__SUBDOM"
[ -z "$__SUBDOM" ] && __URL="${__URL}&name=$__DOMAIN"
__URL="${__URL}&content=$__IP"
__URL="${__URL}&service_mode=0"
__URL="${__URL}&ttl=1"
do_transfer "$__URL" || return 1
cleanup
json_load "$(cat $DATFILE)"
json_get_var __RES "result"
json_get_var __MSG "msg"
return 0
