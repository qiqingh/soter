	local lsctg
	local dpctg
	local ccsg
	local esf
	local esn
	local sesf
	local sesn
	local lossf
	local lossn
	local uasf
	local uasn

	local crc_pf
	local crc_pn
	local crcp_pf
	local crcp_pn
	local hecf
	local hecn

	local fecn
	local fecf

	lsctg=$(dsl_cmd pmlsctg 1)
	esf=$(dsl_val "$lsctg" nES)
	sesf=$(dsl_val "$lsctg" nSES)
	lossf=$(dsl_val "$lsctg" nLOSS)
	uasf=$(dsl_val "$lsctg" nUAS)

	lsctg=$(dsl_cmd pmlsctg 0)
	esn=$(dsl_val "$lsctg" nES)
	sesn=$(dsl_val "$lsctg" nSES)
	lossn=$(dsl_val "$lsctg" nLOSS)
	uasn=$(dsl_val "$lsctg" nUAS)

	dpctg=$(dsl_cmd pmdpctg 0 1)
	hecf=$(dsl_val "$dpctg" nHEC)
	crc_pf=$(dsl_val "$dpctg" nCRC_P)
	crcp_pf=$(dsl_val "$dpctg" nCRCP_P)

	dpctg=$(dsl_cmd pmdpctg 0 0)
	hecn=$(dsl_val "$dpctg" nHEC)
	crc_pn=$(dsl_val "$dpctg" nCRC_P)
	crcp_pn=$(dsl_val "$dpctg" nCRCP_P)

	ccsg=$(dsl_cmd pmccsg 0 1 0)
	fecf=$(dsl_val "$ccsg" nFEC)

	ccsg=$(dsl_cmd pmccsg 0 0 0)
	fecn=$(dsl_val "$ccsg" nFEC)

	if [ "$action" = "lucistat" ]; then
		echo "dsl.errors_fec_near=${fecn:-nil}"
		echo "dsl.errors_fec_far=${fecf:-nil}"
		echo "dsl.errors_es_near=${esn:-nil}"
		echo "dsl.errors_es_far=${esf:-nil}"
		echo "dsl.errors_ses_near=${sesn:-nil}"
		echo "dsl.errors_ses_far=${sesf:-nil}"
		echo "dsl.errors_loss_near=${lossn:-nil}"
		echo "dsl.errors_loss_far=${lossf:-nil}"
		echo "dsl.errors_uas_near=${uasn:-nil}"
		echo "dsl.errors_uas_far=${uasf:-nil}"
		echo "dsl.errors_hec_near=${hecn:-nil}"
		echo "dsl.errors_hec_far=${hecf:-nil}"
		echo "dsl.errors_crc_p_near=${crc_pn:-nil}"
		echo "dsl.errors_crc_p_far=${crc_pf:-nil}"
		echo "dsl.errors_crcp_p_near=${crcp_pn:-nil}"
		echo "dsl.errors_crcp_p_far=${crcp_pf:-nil}"
	else
		echo "Forward Error Correction Seconds (FECS):  Near: ${fecn} / Far: ${fecf}"
		echo "Errored seconds (ES):                     Near: ${esn} / Far: ${esf}"
		echo "Severely Errored Seconds (SES):           Near: ${sesn} / Far: ${sesf}"
		echo "Loss of Signal Seconds (LOSS):            Near: ${lossn} / Far: ${lossf}"
		echo "Unavailable Seconds (UAS):                Near: ${uasn} / Far: ${uasf}"
		echo "Header Error Code Errors (HEC):           Near: ${hecn} / Far: ${hecf}"
		echo "Non Pre-emtive CRC errors (CRC_P):        Near: ${crc_pn} / Far: ${crc_pf}"
		echo "Pre-emtive CRC errors (CRCP_P):           Near: ${crcp_pn} / Far: ${crcp_pf}"
	fi
