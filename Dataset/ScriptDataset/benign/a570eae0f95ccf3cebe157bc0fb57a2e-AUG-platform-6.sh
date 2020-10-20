	[ "$#" -gt 1 ] && return 1

	local file_type=$(platform_identify "$1")
	local magic
	local error=0

	case "$file_type" in
		"chk")
			local header_len=$((0x$(get_magic_long_at "$1" 4)))
			local board_id_len=$(($header_len - 40))
			local board_id=$(dd if="$1" skip=40 bs=1 count=$board_id_len 2>/dev/null | hexdump -v -e '1/1 "%c"')
			local dev_board_id=$(platform_expected_image)
			echo "Found CHK image with device board_id $board_id"

			[ -n "$dev_board_id" -a "chk $board_id" != "$dev_board_id" ] && {
				echo "Firmware board_id doesn't match device board_id ($dev_board_id)"
				error=1
			}

			if ! otrx check "$1" -o "$header_len"; then
				echo "No valid TRX firmware in the CHK image"
				notify_firmware_test_result "trx_valid" 0
				error=1
			else
				notify_firmware_test_result "trx_valid" 1
			fi
		;;
		"cybertan")
			local pattern=$(dd if="$1" bs=1 count=4 2>/dev/null | hexdump -v -e '1/1 "%c"')
			local dev_pattern=$(platform_expected_image)
			echo "Found CyberTAN image with device pattern: $pattern"

			[ -n "$dev_pattern" -a "cybertan $pattern" != "$dev_pattern" ] && {
				echo "Firmware pattern doesn't match device pattern ($dev_pattern)"
				error=1
			}

			if ! otrx check "$1" -o 32; then
				echo "No valid TRX firmware in the CyberTAN image"
				notify_firmware_test_result "trx_valid" 0
				error=1
			else
				notify_firmware_test_result "trx_valid" 1
			fi
		;;
		"lxl")
			local hdr_len=$(get_le_long_at "$1" 8)
			local flags=$(get_le_long_at "$1" 12)
			local board=$(dd if="$1" skip=16 bs=1 count=16 2>/dev/null | hexdump -v -e '1/1 "%c"')
			local dev_board=$(platform_expected_image)
			echo "Found LXL image for board $board"

			[ -n "$dev_board" -a "lxl $board" != "$dev_board" ] && {
				echo "Firmware ($board) doesn't match device ($dev_board)"
				error=1
			}

			[ $((flags & LXL_FLAGS_VENDOR_LUXUL)) -gt 0 ] && notify_firmware_no_backup

			if ! otrx check "$1" -o "$hdr_len"; then
				echo "No valid TRX firmware in the LXL image"
				notify_firmware_test_result "trx_valid" 0
				error=1
			else
				notify_firmware_test_result "trx_valid" 1
			fi
		;;
		"lxlold")
			local board_id=$(dd if="$1" skip=48 bs=1 count=12 2>/dev/null | hexdump -v -e '1/1 "%c"')
			local dev_board_id=$(platform_expected_image)
			echo "Found LXL image with device board_id $board_id"

			[ -n "$dev_board_id" -a "lxl $board_id" != "$dev_board_id" ] && {
				echo "Firmware board_id doesn't match device board_id ($dev_board_id)"
				error=1
			}

			notify_firmware_no_backup

			if ! otrx check "$1" -o 64; then
				echo "No valid TRX firmware in the Luxul image"
				notify_firmware_test_result "trx_valid" 0
				error=1
			else
				notify_firmware_test_result "trx_valid" 1
			fi
		;;
		"safeloader")
		;;
		"seama")
			local img_signature=$(oseama info "$1" | grep "Meta entry:.*signature=" | sed "s/.*=//")
			local dev_signature=$(platform_expected_image)
			echo "Found Seama image with device signature: $img_signature"

			[ -n "$dev_signature" -a "seama $img_signature" != "$dev_signature" ] && {
				echo "Firmware signature doesn't match device signature ($dev_signature)"
				error=1
			}

			$(oseama info "$1" -e 0 | grep -q "Meta entry:.*type=firmware") || {
				echo "Seama container doesn't have firmware entity"
				error=1
			}
		;;
		"trx")
			local expected=$(platform_expected_image)

			[ "$expected" == "safeloader" ] && {
				echo "This device expects SafeLoader format and may not work with TRX"
				error=1
			}

			if ! otrx check "$1"; then
				echo "Invalid (corrupted?) TRX firmware"
				notify_firmware_test_result "trx_valid" 0
				error=1
			else
				notify_firmware_test_result "trx_valid" 1
			fi
		;;
		*)
			echo "Invalid image type. Please use firmware specific for this device."
			notify_firmware_broken
			error=1
		;;
	esac

	return $error
