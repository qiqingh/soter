#!/bin/sh

STAGE_URL="https://www.linksyssmartwifi.com/product-service/rest/productRegistrations"

wan_mac="$(nvram_get 2860 wan_hwaddr)"
model_number="$(nvram_get 2860 model_number)"
fw_ver="$(nvram_get 2860 fw_version)"
hw_ver="$(nvram_get 2860 hw_version)"
sn="$(nvram_get 2860 get_sn)"
CountryCode="$(nvram_get 2860 CountryCode)"
sku="$model_number-$CountryCode"
reg_time="$(date +%Y-%m-%dT%TZ)"
email_addr="$(nvram_get 2860 email_addr)"
optin="$(nvram_get 2860 privacy_policy)"

Linksys_head="X-Cisco-HN-Client-Type-Id:BC7BF185-E064-41B3-9D77-EE1A3AD86837"

echo $Linksys_head
Accept_head="Accept:application/json"
Content_type="Content-type:application/json;charset=UTF-8"


json_data="{\"productRegistration\":{\"serialNumber\":\"$sn\",\"modelNumber\":\"$model_number\",\"sku\":\"$sku\",\"emailAddress\":\"$email_addr\",\"optIn\":\"$optin\",\"registrationDate\":\"$reg_time\",\"hardwareVersion\":\"$hw_ver\",\"firmwareVersion\":\"$fw_ver\",\"macAddress\":\"$wan_mac\"}}"

result=`curl -H "$Linksys_head" -H "$Accept_head" -H "$Content_type" -X POST -d $json_data -k "$STAGE_URL"`
if echo $result | grep "productRegistrationId";then
	nvram_set email_register 1
	echo "Email register Success"
else
	nvram_set email_register 0
	echo "Email register Fail"
fi

