#!/usr/bin/env bash

echo "symlinking desktop entries... this might require sudo access"
sudo ln -s "$(pwd)/zen.desktop /usr/share/applications/zen.desktop"
sudo ln -s "$(pwd)/helium.desktop /usr/share/applications/helium.desktop"
sudo ln -s "$(pwd)/st.desktop /usr/share/applications/st.desktop"
echo "done"
