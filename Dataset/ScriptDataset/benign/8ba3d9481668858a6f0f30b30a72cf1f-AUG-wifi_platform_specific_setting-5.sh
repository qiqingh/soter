	PHY_IF=$1
		is_mbss_needed ${PHY_IF}
		if [ "$?" = "1" ]; then 
			enable_mbss ${PHY_IF}
		fi
