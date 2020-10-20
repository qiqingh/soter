count=0
for i in $1
do
   if [ 0 = `expr $count % 2` ]; then
      NET=$i
   else
      ROUTER=$i
      ip route del $NET via $ROUTER
   fi
   count=`expr $count + 1`
done
