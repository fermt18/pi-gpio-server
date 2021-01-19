#!/bin/bash

# using Raspberry Pi Lite image
# Automatic configurations
raspi-config

# System: set FQDN hostname, change password
# Interface: set SSH
# Performance: Reduce GPU memory to the lowest setting (16 MB)
# Localization: choose timezone, location and keyboard
# Advanced: expand root filesystem
# Update

# Manual configurations
# Static IP
ip link
cd /etc
cp -a dhcpcd.conf dhcpcd.conf.original
vi dhcpcd.conf
#interface eth0
#static ip_address=192.168.1.5/24
#static routers=192.168.1.1
#static domain_name_servers=192.168.1.3 192.168.1.4

# Disable IPv6
cd /etc/sysctl.d
echo "net.ipv6.conf.all.disable_ipv6 = 1" > disable-ipv6.conf
cd /etc/modprobe.d
echo "blacklist ipv6" > blacklist-ipv6.conf

# Disable WiFi, Bluetooth, Audio, Modem, Avahi-daemon
 cd /boot
 cp -a config.txt config.txt.original
 cd /boot
 echo "dtoverlay=disable-bt" >> config.txt
 echo "dtoverlay=disable-wifi" >> config.txt

sed -i '/dtparam=audio/c dtparam=audio=off' config.txt

systemctl mask wpa_supplicant.service

systemctl disable hciuart

systemctl disable avahi-daemon.service


# check filesystemh
df -h

# check memory usage (OS should use about 30MB RAM)
free -h

# create personal account
adduser george
usermod -a -G adm,sudo,users george

# update and reboot
apt update
apt full-upgrade
systemctl reboot

# install cockpit
apt install cockpit




