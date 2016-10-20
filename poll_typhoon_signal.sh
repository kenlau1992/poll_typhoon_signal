#!/bin/bash

HKO_WEB="http://www.weather.gov.hk/contente.htm"
# in second
POLL_INTERVAL=60

get_typhoon_singal()
{
	# use egrep since Mac does not use GNU grep, i.e. no grep -o
	typhoon_singal=`curl -s $HKO_WEB | grep 'images_e/tc[0-9]\+.gif' | egrep -o 'tc[0-9]+'`
	signal_no=`echo $typhoon_singal | egrep -o '[0-9]+'`
}

while : ; do
	get_typhoon_singal
	if [ -z $signal_no ]; then
		echo "No typhoon signal found"
	else
		echo "Signal no. $signal_no"
	fi
	sleep $POLL_INTERVAL
done
