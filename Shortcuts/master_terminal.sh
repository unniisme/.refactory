#!/bin/bash

gnome-terminal
wmctrl -r Terminal -N "Master Terminal"
wmctrl -r "Master Terminal" -b toggle,fullscreen
wmctrl -r "Master Terminal" -t 1
