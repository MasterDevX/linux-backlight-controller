#!/usr/bin/bash

backlight_class=/sys/class/backlight/
monitor=$(xrandr | grep -w connected | awk '{print $1}')

for device in $backlight_class*; do
    if ls -l $device | grep -q $monitor; then
        backlight_device=$device
        break
    fi
done

actual_brightness=$(cat $backlight_device/actual_brightness)
max_brightness=$(cat $backlight_device/max_brightness)
brightness=$backlight_device/brightness

step=$(($max_brightness * $2 / 100))
if [ $1 == "+" ] || [ $1 == "-" ]; then
    new_brightness=$(($actual_brightness $1 $step))
    if [ $new_brightness -lt 0 ]; then
        new_brightness=0
    fi
    if [ $new_brightness -gt $max_brightness ]; then
        new_brightness=$max_brightness
    fi
    echo $new_brightness > $brightness
fi
