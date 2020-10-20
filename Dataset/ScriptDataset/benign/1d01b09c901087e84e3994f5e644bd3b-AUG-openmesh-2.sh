	local cfg=$1 cfg_opt
	local section=$2 our_section=0
	local param=$3 our_param=

	for cfg_opt in $cfg
		do
			[ "$cfg_opt" = "[$section]" ] && our_section=1 && continue
			[ "$our_section" = "1" ] || continue

			our_param=$(echo ${cfg_opt%%=*})
			[ "$param" = "$our_param" ] && echo ${cfg_opt##*=} && break
		done
