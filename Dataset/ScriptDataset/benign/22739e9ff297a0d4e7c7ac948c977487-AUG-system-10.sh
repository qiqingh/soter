	local mac=$1

	echo -ne \\x${mac//:/\\x}
