#!/bin/bash

PROG_NAME=`basename $0`
HKO_WEB="http://www.weather.gov.hk/contente.htm"
# in second
POLL_INTERVAL=60

print_usage()
{
	echo "usage: $PROG_NAME [options]"
	echo "Options:"
	echo "         -h [h]elp"
	echo "         -t Poll [t]ime interval <second>"
}

# print error message and exit
error_and_exit()
{
	local error_code=$1
	shift 1
	if [ ! -z "$1" ]; then
		echo $@
	fi
	exit $error_code
}

parse_args()
{
	until [ -z $1 ]; do
		case $1 in
		-t)
			[ -z "$2" ] && error_and_exit 1 "Input think client directory"
			if [ $2 -eq $2 2>/dev/null ]; then
				POLL_INTERVAL=$2
			else
				error_and_exit 1 "Input '$2' is not a number"
			fi
			shift 2
			;;
		-h)
			print_usage
			exit 0
			;;
		*)
			error_and_exit 2 "Unrecognized input"
			;;
		esac
	done
}

get_typhoon_singal()
{
	# use egrep since Mac does not use GNU grep, i.e. no grep -o
	typhoon_singal=`curl -s $HKO_WEB | grep 'images_e/tc[0-9]\+.gif\|images_e/tc8[a-z]\{2\}.gif' | egrep -o 'tc[0-9]+'`
	signal_no=`echo $typhoon_singal | egrep -o '[0-9]+'`
}

parse_args $@
while : ; do
	get_typhoon_singal
	if [ -z $signal_no ]; then
		echo "No typhoon signal found"
	else
		echo "Signal no. $signal_no"
	fi
	sleep $POLL_INTERVAL
done
