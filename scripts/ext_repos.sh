#!/bin/sh

# Add all of the external repos, that I might need on debian

## ------------------Butterrepo----------------------
curl -fsSL https://justaguylinux.codeberg.page/butterrepo/key.asc | sudo gpg --dearmor -o /usr/share/keyrings/butterrepo.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/butterrepo.gpg] https://justaguylinux.codeberg.page/butterrepo stable main" | sudo tee /etc/apt/sources.list.d/butterrepo.list
## --------------------------------------------------

## ------------------debian.griffo.io----------------
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
## --------------------------------------------------

