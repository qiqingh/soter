	# Builds up a list of iptables commands to flush the qos_* chains,
	# remove rules referring to them, then delete them

	# Print rules in the mangle table, like iptables-save
	for command in $iptables; do
		$command -w -t mangle -S |
			# Find rules for the qos_* chains
			grep -E '(^-N qos_|-j qos_)' |
			# Exclude rules in qos_* chains (inter-qos_* refs)
			grep -v '^-A qos_' |
			# Replace -N with -X and hold, with -F and print
			# Replace -A with -D
			# Print held lines at the end (note leading newline)
			sed -e '/^-N/{s/^-N/-X/;H;s/^-X/-F/}' \
				-e 's/^-A/-D/' \
				-e '${p;g}' |
			# Make into proper iptables calls
			# Note:  awkward in previous call due to hold space usage
			sed -n -e "s/^./${command} -w -t mangle &/p"
	done
