#!/bin/bash

# change to usb directory
cd /media/usb0

# find all music files on usbstick and store as playlist file
find -type f -iregex ".*\.\(acc\|flac\|mp3\|ogg\|wav\)$" | sort --random-sort > /home/pi/jukebox/bin/playlist

# copy playlist to usbstick
sudo cp /home/pi/jukebox/bin/playlist playlist

# play music with playlist
mplayer -playlist playlist