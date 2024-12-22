#!/usr/bin/env bash

if have virt-manager; then
    exit 0
fi

# Qemu/Virt-manager
vm_packages=(
    bridge-utils
    libvirt-clients
    libvirt-daemon
    libvirt-daemon-system
    python3
    python3-pip
    qemu-kvm
    qemu-system
    qemu-utils
    virt-manager
    virtinst
)
sudo apt-get install -y "${vm_packages[@]}"
# sudo virsh net-list --all
sudo usermod -aG libvirt,libvirt-qemu,kvm,input,disk "$USER"
