	local file

	for file in $(ls $1/*.sh 2>/dev/null); do
		. $file
	done
