	local vig
	local cs

	vig=$(dsl_cmd vig)
	cs=$(dsl_val "$vig" DSL_ChipSetType)
	csfw=$(dsl_val "$vig" DSL_ChipSetFWVersion)
	csapi=$(dsl_val "$vig" DSL_DriverVersionApi)

	if [ "$action" = "lucistat" ]; then
		echo "dsl.chipset=\"${cs}\""
		echo "dsl.firmware_version=\"${csfw}\""
		echo "dsl.api_version=\"${csapi}\""
	else
		echo "Chipset:                                  ${cs}"
		echo "Firmware Version:                         ${csfw}"
		echo "API Version:                              ${csapi}"
	fi
