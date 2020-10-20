	local model_string="$1"
	local oIFS="$IFS"; IFS=":"; set -- $model_string; IFS="$oIFS"

	local model="${1%%\(*}"

	AR71XX_MODEL="TP-Link $model v$2"
