	__URL="https://www.cloudflare.com/api_json.html"
	__URL="${__URL}?a=rec_load_all"
	__URL="${__URL}&tkn=$password"
	__URL="${__URL}&email=$username"
	__URL="${__URL}&z=$__DOMAIN"
	do_transfer "$__URL" || return 1
	cleanup
	json_load "$(cat $DATFILE)"
	__FOUND=0
	json_get_var __RES "result"
	json_get_var __MSG "msg"
	[ "$__RES" != "success" ] && {
		write_log 4 "'rec_load_all' failed with error: \n$__MSG"
		return 1
	}
	json_select "response"
	json_select "recs"
	json_select "objs"
	json_get_keys __KEYS
	for __KEY in $__KEYS; do
		local __ZONE __DISPLAY __NAME __TYPE
		json_select "$__KEY"
		json_get_var __NAME "name"
		json_get_var __TYPE "type"
		if [ "$__NAME" = "$domain" ]; then
			[ \( $use_ipv6 -eq 0 -a "$__TYPE" = "A" \) -o \( $use_ipv6 -eq 1 -a "$__TYPE" = "AAAA" \) ] && {
				__FOUND=1
				break
			}
		fi
		json_select ..
	done
	[ $__FOUND -eq 0 ] && {
		write_log 14 "No valid record found at Cloudflare setup. Please create first!"
	}
	json_get_var __RECID "rec_id"
	json_cleanup
	write_log 7 "rec_id '$__RECID' detected for host/domain '$domain'"
