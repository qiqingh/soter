	local var="$1"
	local rules="$2"
	local prefix="$3"
	
	for rule in $rules; do
		unset iptrule
		config_get target "$rule" target
		config_get target "$target" classnr
		config_get options "$rule" options

		## If we want to override the TOS field, let's clear the DSCP field first.
		[ ! -z "$(echo $options | grep 'TOS')" ] && {
			s_options=${options%%TOS}
			add_insmod xt_DSCP
			parse_matching_rule iptrule "$rule" "$s_options" "$prefix" "-j DSCP --set-dscp 0"
			append "$var" "$iptrule" "$N"
			unset iptrule
		}

		target=$(($target | ($target << 4)))
		parse_matching_rule iptrule "$rule" "$options" "$prefix" "-j MARK --set-mark $target/0xff"
		append "$var" "$iptrule" "$N"
	done
