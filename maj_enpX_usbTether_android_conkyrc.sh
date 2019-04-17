#!/bin/bash

# Get the name of the new interface for the android device plugged in

USB_TETHER_ANDROID=$(dmesg | grep 'renamed from usb' | awk -F ' ' {'print $5'} | sed 's/://g')

cp ~/.conky/conkyrc_right ~/.conky/conkyrc_right.back
cp ~/.conky/conkyrc_right.source ~/.conky/conkyrc_right

sed -i "s/USB_ANDROID/$USB_TETHER_ANDROID/g" ~/.conky/conkyrc_right

