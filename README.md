# Poll typhoon signal

DESCRIPTION
------------

The script gets typhoon singal from HK Observatory (HKO) web page. It will
print the typhoon singal number to screen in interval specified by variable
$POLL_INTERVAL in the script or user input. The script stops by Ctrl+C

USAGE
------------
Poll with default time interval
$ ./poll_typhoon_singal
Poll with user config time interval
$ ./poll_typhoon_singal -t <seconds>
Print help
$ ./poll_typhoon_singal -h
