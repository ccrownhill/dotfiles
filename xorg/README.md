# Xorg config for DWM

This is are the configuration for my X window system setup especially for the DWM window manager.

## Note about the urxvt and xterm configuration

These can actually be safely ignored and have been removed from the `setup` script because I have completely switched to `st` on DWM which means that I will not need them anymore.

## Keyboard config

**Note**: The setup script here does not manually place `00-keyboard.conf` in `/etc/X11/xorg.conf.d/`.
Instead it uses `localectl` which does the same.
