	local interface=$1
	local driver=$(uci_get_state network $interface driver)
	ctl_device=$(uci_get_state network $interface ctl_device)
	dat_device=$(uci_get_state network $interface dat_device)

	case $driver in
	qmi_wwan)		proto_qmi_teardown $@ ;;
	cdc_mbim)		proto_mbim_teardown $@ ;;
	sierra_net)		proto_mbim_teardown $@ ;;
	comgt)			proto_3g_teardown $@ ;;
	cdc_ether|*cdc_ncm)	proto_ncm_teardown $@ ;;
	esac
