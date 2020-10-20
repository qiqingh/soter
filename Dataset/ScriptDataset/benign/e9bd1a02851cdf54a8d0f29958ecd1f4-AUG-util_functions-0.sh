getValueForKey() {
   local filename=$1
   grep "^$2:" $filename | cut -d':' -f2
}
