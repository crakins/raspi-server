# linux packages

python2.7-dev, python-pip, git, pianobar, fswebcam, mencoder, usbmount, motion

# pip packages
none at this time

# setup needed

pianobar
config file needs to be created at ~/.config/pianobar/config
create symbolic link - sudo ln -s /h

wifi
edit interfaces file at /etc/network/interfaces

motion
edit config file so stream can be viewed from other computers on network. file located at /etc/motion/motion.conf
change localserver to off

Create symbolic links for timelapse, jukebox
sudo ln -s /home/pi/timelapse/bin/timelapse.sh /usr/bin/timelapse
sudo ln -s /home/pi/jukebox/bin/jukebox/sh /usr/bin/jukebox

