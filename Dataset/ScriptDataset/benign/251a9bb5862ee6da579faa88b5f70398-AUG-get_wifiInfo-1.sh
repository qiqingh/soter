echo "var BasicInfo={"
echo "\"title\": \"Basic Info\","
echo "\"description\": \"basic information about platform\","
echo "\"data\": [{"
echo "	\"vendor\": \"${VENDOR}\","
REGION_CODE=`skuapi -g cert_region | awk -F"=" '{print $2}' | sed 's/ //g'`
if [ -z "$REGION_CODE" ]; then
    REGION_CODE=`syscfg_get device::cert_region`
fi
if [ -z "$REGION_CODE" ]; then
    REGION_CODE="US"
fi
echo "	\"CountryCode\": \"${REGION_CODE}\","
echo "	\"WifiDriverVer\": \"`wl ver | sed 1d | awk '{print $7}'`\""
echo "}]"
echo "};"
