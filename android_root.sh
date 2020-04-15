#!/bin/bash
adb devices
### Unlock of the Bootloader
# reboot to recovery
adb reboot bootloader
# Unlock of the bootloader
fastboot flashing unlock
# Reboot
fastboot reboot

### Root
# Prerequis debug USB
# Download the TWRP
# Download the latest Magisk 
# Reboot to the bootloader 
adb reboot bootloader
# On the bootloader screen
fastboot boot <insert_name_of_TWRP_image_here>.img
# OR
fastboot flash <insert_name_of_TWRP_image_here>.img
# Reboot
# Install of the MAGISK.ZIP


