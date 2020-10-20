	local model_string="$(tplink_pharos_get_model_string | tr -d '\r')"
	local oIFS="$IFS"; IFS=":"; set -- $model_string; IFS="$oIFS"

	local model="${1%%\(*}"

	AR71XX_MODEL="TP-Link $model v$2"
