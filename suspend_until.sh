#!/bin/bash

# Auto suspend and wake-up script
#
# Puts the computer on standby and automatically wakes it up at specified time
#
# Written by Romke van der Meulen <redge.online@gmail.com>
# Minor mods fossfreedom for AskUbuntu
#
# Takes a 24hour time HH:MM as its argument
# Example:
# suspend_until 9:30
# suspend_until 18:45

# ------------------------------------------------------

# https://askubuntu.com/questions/61708/automatically-sleep-and-wake-up-at-specific-times

# suspend until a known time
# A script (at the bottom of this post) could be used to suspend your computer and wake at a specific time:

# syntax is suspend_until [hh:mm] for example

# sudo ./suspend_until 07:30
# Save the script as the name suspend_until and give it execute rights i.e.

# chmod +x suspend_until
# Cron
# You can create a root cron job that calls this script to execute at a specific time in the evening and then awake in the morning:

# sudo crontab -e
# Now enter something like to run the suspend script at 23:30:

# 30 23 * * * /home/myhomefolder/suspend_until 07:30

# ------------------------------------------------------

# Argument check
if [ $# -lt 1 ]; then
    echo "Usage: suspend_until HH:MM"
    exit
fi

# Check whether specified time today or tomorrow
DESIRED=$((`date +%s -d "$1"`))
NOW=$((`date +%s`))
if [ $DESIRED -lt $NOW ]; then
    DESIRED=$((`date +%s -d "$1"` + 24*60*60))
fi

# Kill rtcwake if already running
sudo killall rtcwake

# Set RTC wakeup time
# N.B. change "mem" for the suspend option
# find this by "man rtcwake"
sudo rtcwake -l -m mem -t $DESIRED &

# feedback
echo "Suspending..."

# give rtcwake some time to make its stuff
sleep 2

# then suspend
# N.B. dont usually require this bit
#sudo pm-suspend

# Any commands you want to launch after wakeup can be placed here
# Remember: sudo may have expired by now

# Wake up with monitor enabled N.B. change "on" for "off" if 
# you want the monitor to be disabled on wake
xset dpms force on

# and a fresh console
clear
echo "Good morning!"