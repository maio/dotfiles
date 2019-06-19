#!/bin/bash

# Remap CapsLock to Ctrl (& Escape when pressed alone)
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
