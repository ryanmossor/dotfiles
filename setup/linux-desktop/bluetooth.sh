#!/usr/bin/env bash

if [ -f /etc/udev/rules.d/81-bluetooth-hci.rules ]; then
    echo "ASUS bluetooth driver already installed"
    exit 0
fi
 
wget -O "/tmp/asus_bluetooth.zip" https://dlcdnets.asus.com/pub/ASUS/wireless/USB-BT500/20200909_LINUX_BT_DRIVER_KERNEL_5.7_COEX_v0202.zip
unzip "/tmp/asus_bluetooth.zip" -d "/tmp/asus_bluetooth"
pushd "/tmp/asus_bluetooth/20200806_LINUX_BT_DRIVER_RTL8761B_COEX_v0202/" &> dev/null || exit
sudo make install INTERFACE=usb
popd &> /dev/null || exit

# Disable on-board Bluetooth adapter
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0e8d", ATTRS{idProduct}=="0608", ATTR{authorized}="0"' \
    | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules > /dev/null
