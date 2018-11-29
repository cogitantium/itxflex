#!/bin/bash

# rate of logging
interval=5

# logging-dir prefix
logdir=itxflex-

echo "Starting monitoring of system for written exam. Stop with ctrl + c."

# checks for logging-dir with some id appended
countitxflexdir=`find . -type d -name "$logdir*" | wc -l`

if [ "$countitxflexdir" == 1 ]; then
	# get suffix of first dir and set as id
	existinglogdir=`find . -type d -name "$logdir*" | head -n1`
	id=`echo $existinglogdir | sed -r 's/($logdir)*//' | sed -e 's/.\///'`

	echo id is: $id
else
	echo "Please input your study ID for identification purposes"
	read id
fi

if [ -z "$id" ]; then 
	id=$defaultid
fi

dir=$logdir$id

# creates dir for logging if it doesn't exist yet
mkdir -p $dir

while [ "1" ]; do
	# timestamp with nano and timezone
	timestamp=`date +"%F_%H-%M-%S-%N-%Z"`

	# compose identifier
	identifier=id:$id-time:$timestamp

	# get screenshot, omits multimonitor but stays silent
	scrot $dir/screenshot-$identifier.png -z

	# get ps with hierarchal relationships
	echo `ps axjf` > $dir/processes-$identifier.txt

	# get network config
	echo `iw dev` > $dir/network-$identifier.txt

	# sleep for $interval
	sleep $interval
done;

exit 0
