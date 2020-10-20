	[ -z "$domain" ] && $(echo "$update_url" | grep "\[DOMAIN\]" >/dev/null 2>&1) && \
		write_log 14 "Service section not configured correctly! Missing 'domain'"
	[ -z "$username" ] && $(echo "$update_url" | grep "\[USERNAME\]" >/dev/null 2>&1) && \
		write_log 14 "Service section not configured correctly! Missing 'username'"
	[ -z "$password" ] && $(echo "$update_url" | grep "\[PASSWORD\]" >/dev/null 2>&1) && \
		write_log 14 "Service section not configured correctly! Missing 'password'"
	[ -z "$param_enc" ] && $(echo "$update_url" | grep "\[PARAMENC\]" >/dev/null 2>&1) && \
		write_log 14 "Service section not configured correctly! Missing 'param_enc'"
	[ -z "$param_opt" ] && $(echo "$update_url" | grep "\[PARAMOPT\]" >/dev/null 2>&1) && \
		write_log 14 "Service section not configured correctly! Missing 'param_opt'"
