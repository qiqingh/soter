	local vig
	local cs
	local csv

	vig=$(dsl_cmd vig)
	cs=$(dsl_val "$vig" DSL_ChipSetType)
	csv=$(dsl_val "$vig" DSL_ChipSetHWVersion)
	csfw=$(dsl_val "$vig" DSL_ChipSetFWVersion)
	csapi=$(dsl_val "$vig" DSL_DriverVersionApi)

	if [ "$action" = "lucistat" ]; then
		echo "dsl.chipset=\"${cs} ${csv}\""
		echo "dsl.firmware_version=\"${csfw}\""
		echo "dsl.api_version=\"${csapi}\""
	else
		echo "Chipset:                                  ${cs} ${csv}"
		echo "Firmware Version:                         ${csfw}"
		echo "API Version:                              ${csapi}"
	fi
