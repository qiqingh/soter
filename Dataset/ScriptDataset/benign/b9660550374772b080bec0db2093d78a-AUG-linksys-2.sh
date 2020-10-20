	(get_image "$@" | dd skip=786432 bs=4 count=1 | hexdump -v -n 4 -e '1/1 "%02x"') 2>/dev/null
