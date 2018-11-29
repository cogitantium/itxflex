#!/bin/bash

# rate of logging
interval=5

echo "Starting monitoring of system for written exam"

# checks for itxflex-dir with some id appended
countitxflexdir=`find . -type d -name "itxflex*" | wc -l`
echo itxflexdirs: $countitxflexdir

if [ "$countitxflexdir" == 1 ]; then
	# get suffix of first dir and set as id
	itxflexdir=`find . -type d -name "itxflex-*" | head -n1`
	id=`echo $itxflexdir | sed -e 's/itxflex-//' | sed -e 's/.\///'`
else
	echo "Please input your study ID for identification purposes"
	read id
fi

if [ -z "$id" ]; then 
	id=$defaultid
fi

dir=itxflex-$id

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

exit 0
