# Xorg config for DWM

These are the dotfiles for the Xorg config for the DWM desktop environment used with urxvt (`rxvt-unicode` package on Arch Linux).
I only use these on my Arch Linux machine which is why this setup script is not called by the main setup script.

----

**Note**: The setup script here does not place `00-keyboard.conf` in `/etc/X11/xorg.conf.d/`.
This needs to be done as root.
So just do it manually with:

```
sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/
```

----

**Another note**: If you use `st` instead of `urxvt` you can also use this setup for DWM and just remove or ignore the `urxvt` config stuff in `Xresources` and `Xresources.d`.
