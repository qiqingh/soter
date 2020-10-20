  WORKGROUP=`syscfg get SharedFolderWorkgroup`
  ANON_ACCESS=`syscfg get SharedFolderAnonEna`
  DEVICE_NAME=`hostname`
  if [ ! -f "$SAMBA_CONF_FILE" ] ; then
    CfgDir=`dirname "$SAMBA_CONF_FILE"`
    if [ ! -d "$CfgDir" ] ; then
       mkdir -p "$CfgDir"
    fi
  fi
  echo "# this file was auto-generated and will be overwritten" > $SAMBA_CONF_FILE
  if [ "$WORKGROUP" ] ; then 
    echo "[global]" >> $SAMBA_CONF_FILE
    echo "  netbios name = $DEVICE_NAME" >> $SAMBA_CONF_FILE
    echo "  workgroup = $WORKGROUP" >> $SAMBA_CONF_FILE
    if [ $ANON_ACCESS -gt 0 ] ; then
      echo "  security = share" >> $SAMBA_CONF_FILE
      echo "  guest account = admin" >> $SAMBA_CONF_FILE
    else 
      echo "  security = user" >> $SAMBA_CONF_FILE
      echo "  guest account = guest" >> $SAMBA_CONF_FILE
    fi
    echo "  encrypt passwords = yes" >> $SAMBA_CONF_FILE
    echo "  wins server = " >> $SAMBA_CONF_FILE
    echo "  wins support = no" >> $SAMBA_CONF_FILE
    echo "  preferred master = auto" >> $SAMBA_CONF_FILE
    echo "  domain master = auto" >> $SAMBA_CONF_FILE
    echo "  local master = yes" >> $SAMBA_CONF_FILE
    echo "  domain logons = no" >> $SAMBA_CONF_FILE
    echo "  os level = 65" >> $SAMBA_CONF_FILE
    echo "  passdb backend = smbpasswd:$SAMBA_PASS_FILE" >> $SAMBA_CONF_FILE
    echo "  disable spoolss = yes" >> $SAMBA_CONF_FILE
    echo "  null passwords = yes" >> $SAMBA_CONF_FILE
    echo "  wide links = no" >> $SAMBA_CONF_FILE
    echo "  interfaces = br0" >> $SAMBA_CONF_FILE
    echo "  bind interfaces only = yes" >> $SAMBA_CONF_FILE
    echo "  strict allocate = no" >> $SAMBA_CONF_FILE
    echo "  use sendfile = yes" >> $SAMBA_CONF_FILE
    echo "  oplocks = yes" >> $SAMBA_CONF_FILE
    echo "  level2 oplocks = yes" >> $SAMBA_CONF_FILE
  fi
