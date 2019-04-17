#!/bin/bash
clear
echo "Connexion VPN"
sudo openvpn --mktun --dev tun0
sleep 5
sudo openvpn --config ~/Documents/openvpn_dedibox/client-dedibox.ovpn --dev tun0

