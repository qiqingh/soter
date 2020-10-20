wifi_band=rtdev
cat > $CONFIG_FILE_5G <<EOL
Default
AccessControlList0=`nvram_get $wifi_band AccessControlList0`
AccessControlList1=`nvram_get $wifi_band AccessControlList1`
AccessControlList10=
AccessControlList11=
AccessControlList12=
AccessControlList13=
AccessControlList14=
AccessControlList15=
AccessControlList2=
AccessControlList3=
AccessControlList4=
AccessControlList5=
AccessControlList6=
AccessControlList7=
AccessControlList8=
AccessControlList9=
AccessPolicy0=`nvram_get $wifi_band AccessPolicy0`
AccessPolicy1=`nvram_get $wifi_band AccessPolicy1`
AccessPolicy10=0
AccessPolicy11=0
AccessPolicy12=0
AccessPolicy13=0
AccessPolicy14=0
AccessPolicy15=0
AccessPolicy2=0
AccessPolicy3=0
AccessPolicy4=0
AccessPolicy5=0
AccessPolicy6=0
AccessPolicy7=0
AccessPolicy8=0
AccessPolicy9=0
AckPolicy=0;0;0;0
APACM=0;0;0;0
APAifsn=3;7;1;1
ApCliAuthMode=`nvram_get $wifi_band ApCliAuthMode`
ApCliBssid=
ApCliDefaultKeyID=
ApCliEnable=`nvram_get $wifi_band ApCliEnable`
ApCliAutoConnect=`nvram_get $wifi_band ApCliAutoConnect`
ApCliEncrypType=`nvram_get $wifi_band ApCliEncrypType`
ApCliKey1Str=
ApCliKey1Str1=
ApCliKey1Type=
ApCliKey2Str=
ApCliKey2Str1=
ApCliKey2Type=
ApCliKey3Str=
ApCliKey3Str1=
ApCliKey3Type=
ApCliKey4Str=
ApCliKey4Str1=
ApCliKey4Type=
ApCliSsid=`nvram_get $wifi_band ApCliSsid`
ApCliWirelessMode=
ApCliWPAPSK=`nvram_get $wifi_band ApCliWPAPSK`
ApCliWPAPSK1=
ApCliMuOfdmaDlEnable=1
ApCliMuOfdmaUlEnable=0
ApCliMuMimoDlEnable=0
ApCliMuMimoUlEnable=0
APCwmax=6;10;4;3
APCwmin=4;4;3;2
APSDCapable=1
APTxop=0;0;94;47
AuthMode=`nvram_get $wifi_band AuthMode`
AutoChannelSelect=`nvram_get $wifi_band AutoChannelSelect`
AutoChannelSkipList=
AutoProvisionEn=0
BandSteering=0
BasicRate=`nvram_get $wifi_band BasicRate`
BeaconPeriod=100
BFBACKOFFenable=1
BgndScanSkipCh=
BGProtection=0
BndStrgBssIdx=
BSSACM=0;0;0;0
BSSAifsn=3;7;2;2
BSSCwmax=10;10;4;3
BSSCwmin=4;4;3;2
BssidNum=`nvram_get $wifi_band BssidNum`
BSSTxop=0;0;94;47
BW_Enable=0
BW_Guarantee_Rate=
BW_Maximum_Rate=
BW_Priority=
BW_Root=0
CalCacheApply=0
CarrierDetect=0
Channel=`nvram_get $wifi_band Channel`
ChannelGrp=
CountryCode=`nvram_get $wifi_band CountryCode`
CountryRegion=`nvram_get $wifi_band CountryRegion`
CountryRegionABand=`nvram_get $wifi_band CountryRegionABand`
CP_SUPPORT=2
CSPeriod=6
DBDC_MODE=1
DebugFlags=0
DefaultKeyID=1
DfsCalibration=0
DfsEnable=1
DfsFalseAlarmPrevent=1
DfsZeroWait=0
DfsZeroWaitCacTime=255
DfsDedicatedZeroWait=0
DfsZeroWaitDefault=0
DisableOLBC=0
DtimPeriod=1
E2pAccessMode=`nvram_get $wifi_band E2pAccessMode`
EAPifname=`nvram_get $wifi_band EAPifname`
EDCCAEnable=1
EncrypType=`nvram_get $wifi_band EncrypType`
EthConvertMode=dongle
EtherTrafficBand=0
Ethifname=
ETxBfEnCond=`nvram_get $wifi_band ETxBfEnCond`
FineAGC=0
FixedTxMode=`nvram_get $wifi_band FixedTxMode`
ForceRoamSupport=
FragThreshold=2346
FreqDelta=0
FtSupport=0
GreenAP=0
G_BAND_256QAM=1
HideSSID=`nvram_get $wifi_band HideSSID`
HT_AMSDU=1
AMSDU_NUM=4
HT_AutoBA=1
HT_BADecline=0
HT_BAWinSize=64
HT_BSSCoexistence=1
HT_BW=`nvram_get $wifi_band HT_BW`
HT_DisallowTKIP=1
HT_EXTCHA=1
HT_GI=1
HT_HTC=1
HT_LDPC=`nvram_get $wifi_band HT_LDPC`
HT_LinkAdapt=0
HT_MCS=`nvram_get $wifi_band HT_MCS`
HT_MpduDensity=5
HT_OpMode=0
HT_PROTECT=1
HT_RDG=0
HT_RxStream=`nvram_get $wifi_band HT_RxStream`
HT_STBC=1
HT_TxStream=`nvram_get $wifi_band HT_TxStream`
IcapMode=0
idle_timeout_interval=0
IEEE80211H=1
IEEE8021X=`nvram_get $wifi_band IEEE8021X`
IgmpSnEnable=0
ITxBfEn=`nvram_get $wifi_band ITxBfEn`
Key1Str=
Key1Str1=
Key1Str10=
Key1Str11=
Key1Str12=
Key1Str13=
Key1Str14=
Key1Str15=
Key1Str16=
Key1Str2=
Key1Str3=
Key1Str4=
Key1Str5=
Key1Str6=
Key1Str7=
Key1Str8=
Key1Str9=
Key1Type=0
Key2Str=
Key2Str1=
Key2Str10=
Key2Str11=
Key2Str12=
Key2Str13=
Key2Str14=
Key2Str15=
Key2Str16=
Key2Str2=
Key2Str3=
Key2Str4=
Key2Str5=
Key2Str6=
Key2Str7=
Key2Str8=
Key2Str9=
Key2Type=0
Key3Str=
Key3Str1=
Key3Str10=
Key3Str11=
Key3Str12=
Key3Str13=
Key3Str14=
Key3Str15=
Key3Str16=
Key3Str2=
Key3Str3=
Key3Str4=
Key3Str5=
Key3Str6=
Key3Str7=
Key3Str8=
Key3Str9=
Key3Type=0
Key4Str=
Key4Str1=
Key4Str10=
Key4Str11=
Key4Str12=
Key4Str13=
Key4Str14=
Key4Str15=
Key4Str16=
Key4Str2=
Key4Str3=
Key4Str4=
Key4Str5=
Key4Str6=
Key4Str7=
Key4Str8=
Key4Str9=
Key4Type=0
LinkTestSupport=0
MACRepeaterEn=
MACRepeaterOuiMode=2
MeshAuthMode=
MeshAutoLink=0
MeshDefaultkey=0
MeshEncrypType=
MeshId=
MeshWEPKEY=
MeshWPAKEY=
MUTxRxEnable=`nvram_get $wifi_band MUTxRxEnable`
NoForwarding=0
NoForwardingBTNBSSID=0
own_ip_addr=`nvram_get $wifi_band own_ip_addr`
PcieAspm=0
PERCENTAGEenable=0
PhyRateLimit=0
PMFMFPC=1
PMFMFPR=0
PMFSHA256=0
PMKCachePeriod=`nvram_get $wifi_band PMKCachePeriod`
PowerUpCckOfdm=0:0:0:0:0:0:0
PowerUpHT20=0:0:0:0:0:0:0
PowerUpHT40=0:0:0:0:0:0:0
PowerUpVHT160=0:0:0:0:0:0:0
PowerUpVHT20=0:0:0:0:0:0:0
PowerUpVHT40=0:0:0:0:0:0:0
PowerUpVHT80=0:0:0:0:0:0:0
PreAntSwitch=
PreAuth=0
PreAuthifname=`nvram_get $wifi_band PreAuthifname`
RadioLinkSelection=0
RadioOn=1
RADIUS_Acct_Key=
RADIUS_Acct_Port=1813
RADIUS_Acct_Server=
RADIUS_Key1=`nvram_get $wifi_band RADIUS_Key1`
RADIUS_Key10=
RADIUS_Key11=
RADIUS_Key12=
RADIUS_Key13=
RADIUS_Key14=
RADIUS_Key15=
RADIUS_Key16=
RADIUS_Key2=
RADIUS_Key3=
RADIUS_Key4=
RADIUS_Key5=
RADIUS_Key6=
RADIUS_Key7=
RADIUS_Key8=
RADIUS_Key9=
RADIUS_Port=`nvram_get $wifi_band RADIUS_Port`
RADIUS_Server=`nvram_get $wifi_band RADIUS_Server`
RDRegion=
RED_Enable=1
RekeyInterval=3600
RekeyMethod=`nvram_get $wifi_band RekeyMethod`
RRMEnable=1
RTSThreshold=2347
session_timeout_interval=`nvram_get $wifi_band session_timeout_interval`
ShortSlot=1
SkuTableIdx=0
SKUenable=1
SREnable=1
SRMode=0
SRSDEnable=1
PPEnable=0
SSID=
SSID1=`nvram_get $wifi_band SSID1`
SSID10=
SSID11=
SSID12=
SSID13=
SSID14=
SSID15=
SSID16=
SSID2=`nvram_get $wifi_band SSID2`
SSID3=
SSID4=
SSID5=
SSID6=
SSID7=
SSID8=
SSID9=
StationKeepAlive=0
StreamMode=0
StreamModeMac0=
StreamModeMac1=
StreamModeMac2=
StreamModeMac3=
TGnWifiTest=0
ThermalRecal=0
CCKTxStream=4
TWTSupport=1
TxBurst=1
TxPower=100
TxPreamble=1
VHT_BW=`nvram_get $wifi_band VHT_BW`
VHT_BW_SIGNAL=0
VHT_LDPC=1
VHT_Sec80_Channel=0
VHT_SGI=1
VHT_STBC=1
VLANID=0
VLANPriority=0
VLANTag=0
VOW_Airtime_Ctrl_En=0
VOW_Airtime_Fairness_En=1
VOW_BW_Ctrl=0
VOW_Group_Backlog=
VOW_Group_DWRR_Max_Wait_Time=
VOW_Group_DWRR_Quantum=
VOW_Group_Max_Airtime_Bucket_Size=
VOW_Group_Max_Rate=
VOW_Group_Max_Rate_Bucket_Size=
VOW_Group_Max_Ratio=
VOW_Group_Max_Wait_Time=
VOW_Group_Min_Airtime_Bucket_Size=
VOW_Group_Min_Rate=
VOW_Group_Min_Rate_Bucket_Size=
VOW_Group_Min_Ratio=
VOW_Rate_Ctrl_En=0
VOW_Refill_Period=
VOW_RX_En=1
VOW_Sta_BE_DWRR_Quantum=
VOW_Sta_BK_DWRR_Quantum=
VOW_Sta_DWRR_Max_Wait_Time=
VOW_Sta_VI_DWRR_Quantum=
VOW_Sta_VO_DWRR_Quantum=
VOW_WATF_Enable=
VOW_WATF_MAC_LV0=
VOW_WATF_MAC_LV1=
VOW_WATF_MAC_LV2=
VOW_WATF_MAC_LV3=
VOW_WATF_Q_LV0=
VOW_WATF_Q_LV1=
VOW_WATF_Q_LV2=
VOW_WATF_Q_LV3=
VOW_WMM_Search_Rule_Band0=
VOW_WMM_Search_Rule_Band1=
WapiAsCertPath=
WapiAsIpAddr=
WapiAsPort=
Wapiifname=
WapiPsk1=
WapiPsk10=
WapiPsk11=
WapiPsk12=
WapiPsk13=
WapiPsk14=
WapiPsk15=
WapiPsk16=
WapiPsk2=
WapiPsk3=
WapiPsk4=
WapiPsk5=
WapiPsk6=
WapiPsk7=
WapiPsk8=
WapiPsk9=
WapiPskType=
WapiUserCertPath=
WCNTest=0
Wds0Key=
Wds1Key=
Wds2Key=
Wds3Key=
WdsEnable=0
WdsEncrypType=NONE
WdsList=
WdsPhyMode=0
WHNAT=0
WiFiTest=0
WirelessMode=`nvram_get $wifi_band WirelessMode`
WmmCapable=1
WPAPSK=
WPAPSK1=`nvram_get $wifi_band WPAPSK1`
WPAPSK10=
WPAPSK11=
WPAPSK12=
WPAPSK13=
WPAPSK14=
WPAPSK15=
WPAPSK16=
WPAPSK2=
WPAPSK3=
WPAPSK4=
WPAPSK5=
WPAPSK6=
WPAPSK7=
WPAPSK8=
WPAPSK9=
WscConfMode=`nvram_get $wifi_band WscConfMode`
WscConfStatus=`nvram_get $wifi_band WscConfStatus`
TxCmdMode=1
MuOfdmaDlEnable=1
MuOfdmaUlEnable=1
MuMimoDlEnable=1
MuMimoUlEnable=1
MapMode=0
MboSupport=1
MU_OFDMA_UL_En=
PowerUpenable=0
DL_Users=
TWTRequired=1
TWTResponder=1
DL_OFDMA_RU=0
MU_OFDMA_DL_En=
UL_OFDMA_RU_Alloc=0
TxOP=
DL_PPDU_Format=0
BssColor=
HE_SU_LTF=1
UL_Users=
RU_Indices=1
CoLocatedBSSID=1
UL_RU_Indices=1
MacAddress=$MAC2
WscVendorPinCode=$PIN
EOL
