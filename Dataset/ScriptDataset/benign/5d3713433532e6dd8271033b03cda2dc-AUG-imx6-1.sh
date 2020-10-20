	local cmdline=$(cat /proc/cmdline)
	local bootpart=${cmdline##*root=}
	bootpart=${bootpart%% *}
	local uuid=${bootpart#PARTUUID=}
	echo ${uuid%-02}
