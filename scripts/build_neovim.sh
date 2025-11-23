#!/usr/bin/env bash

echo "This action requires your sudo password"

echo "Cloning Neovim repository..."
git clone https://github.com/neovim/neovim.git
cd neovim || exit
git chekout stable

echo "Building Neovim..."
make CMAKE_BUILD_TYPE=Release

echo "Installing Neovim...this action requires your sudo password"
sudo make install
