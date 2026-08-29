#!/usr/bin/env bash

[ -f /etc/udev/rules.d/51-gcadapter.rules ] && exit 0

# Configure Wii U GC adapter for Dolphin (https://dolphin-emu.org/docs/guides/how-use-official-gc-controller-adapter-wii-u/#Linux)
echo 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"' \
    | sudo tee /etc/udev/rules.d/51-gcadapter.rules > /dev/null
sudo udevadm control --reload-rules

case "$os" in
    omarchy)
        wiiu_deps=(
            libusb
            make
        )
        omarchy-pkg-add "${wiiu_deps[@]}"
        echo uinput | sudo tee /etc/modules-load.d/uinput.conf
        ;;
    ubuntu)
        wiiu_deps=(
            libudev-dev
            libusb-1.0-0
            libusb-1.0-0-dev
            make
        )
        sudo apt-get install -y "${wiiu_deps[@]}"
        ;;
esac

git clone https://github.com/ToadKing/wii-u-gc-adapter /tmp/wiiu
pushd /tmp/wiiu &> /dev/null || exit
make
chmod +x ./wii-u-gc-adapter
sudo mv ./wii-u-gc-adapter /usr/local/bin
popd &> /dev/null || exit

