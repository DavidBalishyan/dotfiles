#!/bin/env bash

# Script to install GCC and related tools on Debian-based, Arch-based, and Void Linux distros

set -e

# Detect distro and install packages accordingly
if [ -f /etc/debian_version ]; then
    echo "Debian-based system detected. Installing GCC and build tools..."
    sudo apt update
    sudo apt install -y build-essential gcc g++ make cmake

elif [ -f /etc/arch-release ]; then
    echo "Arch-based system detected. Installing GCC and build tools..."
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm base-devel gcc make cmake

elif [ -f /etc/void-release ] || grep -qi 'void' /etc/os-release 2>/dev/null; then
    echo "Void Linux detected. Installing GCC and build tools..."
    sudo xbps-install -Syu
    sudo xbps-install -y base-devel gcc make cmake

else
    echo "Unsupported Linux distribution. Please install GCC manually."
    exit 1
fi

echo "GCC and build tools installation complete."

