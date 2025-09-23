#!/usr/bin/env bash
set -e

echo "=== Updating package lists ==="
sudo apt update -y

echo "=== Installing dependencies ==="
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev \
    libxcb-xfixes0-dev libxkbcommon-dev python3 git

# If alacritty folder not present, clone it in current dir
if [ ! -d "./alacritty" ]; then
    echo "=== Cloning Alacritty repository ==="
    git clone https://github.com/alacritty/alacritty.git
else
    echo "=== Alacritty repo already exists, pulling latest changes ==="
    cd ./alacritty
    git pull
    cd ..
fi

cd ./alacritty

echo "=== Installing Alacritty ==="
cargo install --path .


# echo "=== Building Alacritty ==="
# cargo build --release

# echo "=== Installing binary ==="
# sudo cp target/release/alacritty /usr/local/bin/

echo "=== Installing icon ==="
sudo cp extra/logo/alacritty-term.svg /usr/share/icons/hicolor/scalable/apps/Alacritty.svg

echo "=== Installing .desktop entry ==="
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

echo "=== Installing terminfo (for compatibility) ==="
tic -xe alacritty,alacritty-direct extra/alacritty.info

echo "=== Done! ==="
echo "You should now see Alacritty in your application menu/launcher."

