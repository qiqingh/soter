	local machine="$1"

	case "$machine" in
	*"2011iL")
		name="rb-2011il"
		;;
	*"2011iLS")
		name="rb-2011ils"
		;;
	*"2011L")
		name="rb-2011l"
		;;
	*"2011UAS")
		name="rb-2011uas"
		;;
	*"2011UAS-2HnD")
		name="rb-2011uas-2hnd"
		;;
	*"2011UiAS")
		name="rb-2011uias"
		;;
	*"2011UiAS-2HnD")
		name="rb-2011uias-2hnd"
		;;
	*"2011UiAS-2HnD r2")
		name="rb-2011uias-2hnd-r2"
		;;
	*"411/A/AH")
		name="rb-411"
		;;
	*"411U")
		name="rb-411u"
		;;
	*"433/AH")
		name="rb-433"
		;;
	*"433UAH")
		name="rb-433u"
		;;
	*"435G")
		name="rb-435g"
		;;
	*"450")
		name="rb-450"
		;;
	*"450G")
		name="rb-450g"
		;;
	*"493/AH")
		name="rb-493"
		;;
	*"493G")
		name="rb-493g"
		;;
	*"750")
		name="rb-750"
		;;
	*"750 r2"|\
	*"750r2")
		name="rb-750-r2"
		;;
	*"750GL")
		name="rb-750gl"
		;;
	*"750P r2")
		name="rb-750p-pbr2"
		;;
	*"750UP r2"|\
	*"750UPr2")
		name="rb-750up-r2"
		;;
	*"751")
		name="rb-751"
		;;
	*"751G")
		name="rb-751g"
		;;
	*"911-2Hn")
		name="rb-911-2hn"
		;;
	*"911-5Hn")
		name="rb-911-5hn"
		;;
	*"911G-2HPnD")
		name="rb-911g-2hpnd"
		;;
	*"911G-5HPacD")
		name="rb-911g-5hpacd"
		;;
	*"911G-5HPnD")
		name="rb-911g-5hpnd"
		;;
	*"912UAG-2HPnD")
		name="rb-912uag-2hpnd"
		;;
	*"912UAG-5HPnD")
		name="rb-912uag-5hpnd"
		;;
	*"921GS-5HPacD r2")
		name="rb-921gs-5hpacd-r2"
		;;
	*"922UAGS-5HPacD")
		name="rb-922uags-5hpacd"
		;;
	*"931-2nD")
		name="rb-931-2nd"
		;;
	*"941-2nD")
		name="rb-941-2nd"
		;;
	*"951G-2HnD")
		name="rb-951g-2hnd"
		;;
	*"951Ui-2HnD")
		name="rb-951ui-2hnd"
		;;
	*"951Ui-2nD")
		name="rb-951ui-2nd"
		;;
	*"952Ui-5ac2nD")
		name="rb-952ui-5ac2nd"
		;;
	*"962UiGS-5HacT2HnT")
		name="rb-962uigs-5hact2hnt"
		;;
	*"LHG 5nD")
		name="rb-lhg-5nd"
		;;
	*"mAP 2nD"|\
	*"mAP2nD")
		name="rb-map-2nd"
		;;
	*"mAP L-2nD"|\
	*"mAPL-2nD")
		name="rb-mapl-2nd"
		;;
	*"SXT 2nD r3")
		name="rb-sxt-2nd-r3"
		;;
	*"SXT Lite2")
		name="rb-sxt2n"
		;;
	*"SXT Lite5")
		name="rb-sxt5n"
		;;
	*"wAP 2nD r2")
		name="rb-wap-2nd"
		;;
	*"wAP R-2nD"|\
	*"wAPR-2nD")
		name="rb-wapr-2nd"
		;;
	*"wAP G-5HacT2HnD"|\
	*"wAPG-5HacT2HnD")
		name="rb-wapg-5hact2hnd"
		;;
	esac

	echo "$name"
