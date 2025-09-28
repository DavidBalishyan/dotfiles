#!/bin/env bash

# Script to install GCC, build tools, and essential development utilities
# Supports Debian-based, Arch-based, and Void Linux distributions

set -e

echo "Detecting Linux distribution..."

if [ -f /etc/debian_version ]; then
    echo "Debian-based system detected. Installing packages..."
    sudo apt update
    sudo apt install -y \
        build-essential gcc g++ make cmake \
        git curl wget pkg-config \
        gdb manpages-dev strace lsof \
        vim

elif [ -f /etc/arch-release ]; then
    echo "Arch-based system detected. Installing packages..."
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm \
        base-devel gcc make cmake \
        git curl wget pkgconf \
        gdb man-db strace lsof \
        vim

elif [ -f /etc/void-release ] || grep -qi 'void' /etc/os-release 2>/dev/null; then
    echo "Void Linux detected. Installing packages..."
    sudo xbps-install -Syu
    sudo xbps-install -y \
        base-devel gcc make cmake \
        git curl wget pkg-config \
        gdb man-pages strace lsof \
        vim

else
    echo "Unsupported Linux distribution. Please install packages manually."
    exit 1
fi

echo "Succes."

