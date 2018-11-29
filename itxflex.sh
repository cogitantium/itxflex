#!/bin/bash

# rate of logging
interval=5

echo "Starting monitoring of system for written exam"

# checks for itxflex-dir with some id appended
countitxflexdir=`find . -type d -name "itxflex*" | wc -l`
echo itxflexdirs: $countitxflexdir

if [ "$countitxflexdir" == 1 ]; then
	# get suffix of dir and set as id
	itxflexdir=`find . -type d -name "itxflex" | head -n1`
	echo $itxflexdir	
	
	#echo `sed -e 's/itxflex-//g' $itxflexdir`
	id=`$itxflexdir | sed -e 's/itxflex-//g'`
	echo id is: $id

else
	echo "Please input your study ID for identification purposes"
	read id
fi

dir=itxflex-$id

echo dir is: $dir

# creates dir for logging if it doesn't exist yet
mkdir -p $dir

# create sensible loop here

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
