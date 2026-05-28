#!/bin/env bash

source "$(dirname "$0")/board.bash"

require_root

header "Essential Development Tools Installer"

if is_linux; then
    if [ -f /etc/debian_version ]; then
        info "Debian-based system detected. Installing packages..."
        run sudo apt update
        run sudo apt install -y \
            build-essential gcc g++ make cmake \
            git curl wget pkg-config \
            gdb manpages-dev strace lsof \
            vim

    elif [ -f /etc/arch-release ]; then
        info "Arch-based system detected. Installing packages..."
        run sudo pacman -Syu --noconfirm
        run sudo pacman -S --noconfirm \
            base-devel gcc make cmake \
            git curl wget pkgconf \
            gdb man-db strace lsof \
            vim

    elif [ -f /etc/void-release ] || grep -qi 'void' /etc/os-release 2>/dev/null; then
        info "Void Linux detected. Installing packages..."
        run sudo xbps-install -Syu
        run sudo xbps-install -y \
            base-devel gcc make cmake \
            git curl wget pkg-config \
            gdb man-pages strace lsof \
            vim

    else
        die "Unsupported Linux distribution. Please install packages manually."
    fi
else
    die "This script is for Linux only."
fi

ok "Success."

