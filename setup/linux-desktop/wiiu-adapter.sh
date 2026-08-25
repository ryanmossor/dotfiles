#!/usr/bin/env bash

if [ -f /etc/udev/rules.d/51-gcadapter.rules ]; then
    echo "Wii-U GC adapter already configured"
    exit 0
fi

# Configure Wii U GC adapter for Dolphin (https://dolphin-emu.org/docs/guides/how-use-official-gc-controller-adapter-wii-u/#Linux)
echo 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"' \
    | sudo tee /etc/udev/rules.d/51-gcadapter.rules > /dev/null
sudo udevadm control --reload-rules

wiiu_deps=(
    libudev-dev
    libusb-1.0-0
    libusb-1.0-0-dev
    make
)
sudo apt-get install -y "${wiiu_deps[@]}"

git clone https://github.com/ToadKing/wii-u-gc-adapter /tmp/wiiu
pushd /tmp/wiiu &> /dev/null || exit
make
chmod +x ./wii-u-gc-adapter
sudo mv ./wii-u-gc-adapter /usr/local/bin
popd &> /dev/null || exit

