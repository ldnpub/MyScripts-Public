#!/bin/bash
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

while true; do
    read -p "Chose exit node country: [1-US] [2-CH] [3-UK] : " country
    case $country in
        [1]* ) openvpn /home/ldnpub/.vpn/us.ovpn;;
        [2]* ) openvpn /home/ldnpub/.vpn/ch.ovpn;;
	[3]* ) openvpn /home/ldnpub/.vpn/uk.ovpn;;
        * ) echo "Please choose 1, 2 or 3";;
    esac
done
