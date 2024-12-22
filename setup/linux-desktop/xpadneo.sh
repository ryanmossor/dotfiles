#!/usr/bin/env bash

# Xpadneo https://github.com/atar-axis/xpadneo
xpadneo_dir="/home/$USER/code/xpadneo" 
if [ -d "$xpadneo_dir" ]; then
    pushd "$xpadneo_dir"  &> /dev/null || exit
    git pull
    sudo ./update.sh
else
    sudo apt-get install -y dkms linux-headers-"$(uname -r)"
    git clone https://github.com/atar-axis/xpadneo.git "$xpadneo_dir" 
    pushd "$xpadneo_dir" &> /dev/null || exit
    sudo ./install.sh
fi
popd &> /dev/null || exit

if ! grep "MinConnectionInterval" /etc/bluetooth/main.conf &> /dev/null; then
    # Xbox controller input delay fix
	sudo cp /etc/bluetooth/main.conf /etc/bluetooth/main.conf.BAK
	cat >> "/etc/bluetooth/main.conf" <<-EOF
	[LE]
	MinConnectionInterval=7
	MaxConnectionInterval=9
	ConnectionLatency=0
	EOF
    sudo systemctl restart bluetooth.service
else
    echo "Xbox delay fix already implemented"
fi

