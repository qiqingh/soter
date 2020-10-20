   local filename=$1
   local tmp_file="${filename}.tmp"
   local key=$2
   local val=$3
   if ! grep -q "^$key:" $filename;
   then
      echo "$key:$val" >> $filename
   else
      sed "s/$key[:].*/$key:$val/" $filename > $tmp_file
      mv -f $tmp_file $filename
   fi
