
  id=1
  lastid=0
  
  for mac in $(wl_rt2880 assoclist | cut -d" " -f2)
  do
    if test $lastid -eq 0
    then
      getnext_1361412021255="$place.3.54.1.3.32.1.1.1"
      getnext_1361412021255354133211="$place.3.54.1.3.32.1.1.1"
      getnext_1361412021255354133214="$place.3.54.1.3.32.1.4.1"
      getnext_13614120212553541332113="$place.3.54.1.3.32.1.13.1"
      getnext_13614120212553541332126="$place.3.54.1.3.32.1.26.1"
    else
      eval getnext_1361412021255354133211${lastid}="$place.3.54.1.3.32.1.1.$id"
      eval getnext_1361412021255354133214${lastid}="$place.3.54.1.3.32.1.4.$id"
      eval getnext_13614120212553541332113${lastid}="$place.3.54.1.3.32.1.13.$id"
      eval getnext_13614120212553541332126${lastid}="$place.3.54.1.3.32.1.26.$id"
    fi
  
    rssi=$(wl_rt2880 rssi $mac | cut -d" " -f3)
    noise_reference=$(wl_rt2880 noise $mac | cut -d" " -f3)
    if test $rssi -eq 0
    then
      snr=0
    else
      let snr=-1*$noise_reference+$rssi
    fi
    mac=$(echo $mac | tr : ' ')
  
    eval value_1361412021255354133211${id}=$id;
    eval type_1361412021255354133211${id}='integer';
    eval value_1361412021255354133214${id}='$mac';
    eval type_1361412021255354133214${id}='octet';
    eval value_13614120212553541332113${id}=$noise_reference;
    eval type_13614120212553541332113${id}='integer';
    eval value_13614120212553541332126${id}=$snr;
    eval type_13614120212553541332126${id}='integer';

    lastid=$id
    let id=$id+1
  
  done

  if test $lastid -ne 0
  then
    eval getnext_1361412021255354133211${lastid}="$place.3.54.1.3.32.1.4.1"
    eval getnext_1361412021255354133214${lastid}="$place.3.54.1.3.32.1.13.1"
    eval getnext_13614120212553541332113${lastid}="$place.3.54.1.3.32.1.26.1"
    eval getnext_13614120212553541332126${lastid}="NONE"
  fi
