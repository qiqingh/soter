	local cal_src=$1
	local cal_dst=$2
	local mtd_src
	local mtd_dst
	local md5_src
	local md5_dst

	mtd_src=$(find_mtd_part $cal_src)
	[ -z "$mtd_src" ] && {
		echo "no $cal_src partition found"
		return 1
	}

	mtd_dst=$(find_mtd_part $cal_dst)
	[ -z "$mtd_dst" ] && {
		echo "no $cal_dst partition found"
		return 1
	}

	dir825b_is_caldata_valid "$mtd_src" && {
		echo "no valid calibration data found in $cal_src"
		return 1
	}

	dir825b_is_caldata_valid "$mtd_dst" && {
		echo "Copying calibration data from $cal_src to $cal_dst..."
		dd if="$mtd_src" 2>/dev/null | mtd -q -q write - "$cal_dst"
	}

        md5_src=$(md5sum "$mtd_src") && md5_src="${md5_src%% *}"
        md5_dst=$(md5sum "$mtd_dst") && md5_dst="${md5_dst%% *}"

	[ "$md5_src" != "$md5_dst" ] && {
		echo "calibration data mismatch $cal_src:$md5_src $cal_dst:$md5_dst"
		return 1
	}

	return 0
