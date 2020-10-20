#!/bin/sh
echo [$0] ... > /dev/console
TXPOWER_NODE=`rgdb -g /wlan/inf:1/txpower`
TXPOWER_RUNTIME=`rgdb -i -g /runtime/stats/wlan/inf:1/txpower`
txpower=`rgdb -g /wlan/inf:1/txpower`
WLAN_ENABLE=`rgdb -g /wlan/inf:1/enable`
if [ "$WLAN_ENABLE" = "1" ]; then
	if [ "$txpower" != "1" ]; then
		ifconfig ath0 down
		brctl delif br0 ath0
		d=`expr $TXPOWER_RUNTIME \* "2"`
			#75%
			if [ "$TXPOWER_NODE" = "5" ]; then
				if [ "$TXPOWER_RUNTIME" -gt "1" ]; then
					e=`expr \( $TXPOWER_RUNTIME - "1" \)`
					e1=`expr $e \* "2"`
					# By atheros design when you setting txpower vaule must double it.
					iwpriv wifi0 TXPwrOvr $e1
				else
					iwpriv wifi0 TXPwrOvr 2
				fi
			#50%
			elif [ "$TXPOWER_NODE" = "2" ]; then
				if [ "$TXPOWER_RUNTIME" -gt "3" ]; then
					a=`expr \( $TXPOWER_RUNTIME - "3" \)`
					a1=`expr $a \* "2"`			
					iwpriv wifi0 TXPwrOvr $a1
				else
					iwpriv wifi0 TXPwrOvr 2
				fi
			#25%
			elif [ "$TXPOWER_NODE" = "3" ]; then
				if [ "$TXPOWER_RUNTIME" -gt "6" ]; then
					b=`expr \( $TXPOWER_RUNTIME - "6" \)`
					b1=`expr $b \* "2"`
					echo b1==$b1
					
					iwpriv wifi0 TXPwrOvr $b1
				else
					iwpriv wifi0 TXPwrOvr 2
				fi
			elif [ "$TXPOWER_NODE" = "4" ]; then
				if [ "$TXPOWER_RUNTIME" -gt "9" ]; then
					c=`expr \( $TXPOWER_RUNTIME - "9" \)`
					c1=`expr $c \* "2"`
					echo c1==$c1
					iwpriv wifi0 TXPwrOvr $c1
				else
					iwpriv wifi0 TXPwrOvr 2
				fi
			else
				iwpriv wifi0 TXPwrOvr $d
			fi
		ifconfig ath0 up
		brctl addif br0 ath0
	fi
fi
