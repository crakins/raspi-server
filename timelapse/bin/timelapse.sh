#!/bin/bash

# Declare variables
# Get timestamp
timestamp=$(date +%Y%m%d-%H%M%S)

# Get name of video, piccount, pictimer, and FPS
# Error handling for duplicate directory names and greater than 15 second interval

echo “What is the name of this timelpase video?: ”
read NAME
if [ -d "/home/pi/timelapse/"$NAME ]
then
	oldNAME=$NAME
	NAME=${NAME}$timestamp
	echo -e "NOTICE: The name "$oldNAME" already exists! \nNOTICE: Your video name will be" $NAME"."
fi
echo “How many photos to take?”
read piccount
echo “How many seconds between each photo?[Must be great than 15]”
read pictimer
if [ $pictimer -le 14 ]
then
	pictimer=15
	echo "Nice try. Interval is" $pictimer "seconds."
fi
echo “How many frames per second [use 30 if you are not sure]?”
read framespersecond
echo “Delete all pictures after creating video [y/n]?”
# error handling for y or n response
read deletePics
echo "Got it. The webcam will now take "$piccount" pictures, at "$pictimer" second intervals.  FPS is "$framespersecond". This may take a while..."

# Change to fswebcam directory
cd /home/pi/timelapse

# Create new directory for timelapse from timestamp
mkdir $NAME

# While loop to take photos with timelapse.conf
i=0

while [[ $i -lt $piccount ]]; do
   fswebcam -c timelapse.conf --save $NAME/$NAME-%Y-%m-%d%H:%M:%S.jpg
   sleep $pictimer
   let i=$i+1
done

# Create Timelapse video using mencoder
# navigate to directory
cd $NAME

# create frames.txt file for mencoder to read from
ls -1tr > frames.txt

# run mencoder 
# mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell:autoaspect:vqscale=3 -vf scale=640:480 -mf type=jpeg:fps=$framespersecond mf://@frames.txt -o $NAME.avi
mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=640:480 -o $NAME.avi -mf type=jpeg:fps=$framespersecond mf://@frames.txt

# remove all jpg and txt files if deletePics == y
if [ "$deletePics" == "y" ]; then
rm *.jpg *.txt
fi
