	local image="$1"
	local offset="$2"
	local model="$3"

	# Here $image is given to dd directly instead of using get_image;
	# otherwise the skip will take almost a second (as dd can't seek)
	dd if="$image" bs=1 skip=$offset count=1024 2>/dev/null | (
		while IFS= read -r line; do
			[ "$line" = "$model" ] && exit 0
		done

		exit 1
	)
