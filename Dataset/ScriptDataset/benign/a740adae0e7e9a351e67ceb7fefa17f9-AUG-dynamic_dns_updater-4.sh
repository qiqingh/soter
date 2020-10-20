	uci -q set ddns.$SECTION_ID.lookup_host="$domain"
	uci -q commit ddns
	lookup_host="$domain"
