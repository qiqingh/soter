
    cat <<EOF
Usage: $0 [show|set_sku SKU|set_country COUNTRY]
  SKU options: US,AH,CN,CA,KR
  COUNTRY options for AH SKU: HKG,IND,PHI,SGP,TWN,THA,XAH,
 Note: The system will reboot if SKU is changed.
 
EOF
    exit 1
