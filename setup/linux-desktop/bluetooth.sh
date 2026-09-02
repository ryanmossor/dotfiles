#!/usr/bin/env bash

if [ ! -f /etc/udev/rules.d/81-bluetooth-hci.rules ]; then
    wget -O "/tmp/asus_bluetooth.zip" https://dlcdnets.asus.com/pub/ASUS/wireless/USB-BT500/20200909_LINUX_BT_DRIVER_KERNEL_5.7_COEX_v0202.zip
    unzip "/tmp/asus_bluetooth.zip" -d "/tmp/asus_bluetooth"
    pushd "/tmp/asus_bluetooth/20200806_LINUX_BT_DRIVER_RTL8761B_COEX_v0202/20200806_LINUX_BT_DRIVER_RTL8761B_COEX_v0202" &> /dev/null || exit
    sudo make install INTERFACE=usb
    popd &> /dev/null || exit

    # Disable on-board Bluetooth adapter
    echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0e8d", ATTRS{idProduct}=="0608", ATTR{authorized}="0"' \
        | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules > /dev/null
fi

# if [ ! -f /etc/udev/rules.d/99-bluetooth-usb-autosuspend.rules ]; then
#     # ASUS USB-BT500 (Realtek RTL8761B) - firmware fails to wake from USB
#     # autosuspend, causing a hci0 command-timeout/reset loop every ~2s.
#     sudo tee /etc/udev/rules.d/99-bluetooth-usb-autosuspend.rules > /dev/null << 'EOF'
# ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0b05", ATTR{idProduct}=="190e", TEST=="power/control", ATTR{power/control}="on"
# EOF
#     sudo udevadm control --reload-rules
# fi
