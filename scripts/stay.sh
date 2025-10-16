#!/usr/bin/env bash

wezterm -e bash -c "$*; echo -e; tput setaf 5 bold; \
    read -p 'Press any key to exit ' -s -n 1"
