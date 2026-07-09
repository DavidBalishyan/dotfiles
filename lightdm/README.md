# lightdm

LightDM login screen config, using the GTK greeter with a Tokyonight-Dark theme.

## Files

- `lightdm.conf`: the LightDM daemon config. Sets the GTK greeter and makes bspwm the default session.
- `lightdm-gtk-greeter.conf`: the greeter's appearance, meaning theme, icons, font, wallpaper, and panel.
- `install.sh`: sets this up on a fresh machine.

## Setup

Run `./install.sh`. It installs the packages, builds the theme, symlinks both configs into `/etc/lightdm`, and sets the traverse permission described below.

## The permission gotcha

The greeter runs as the `lightdm` user, and my home directory is `700`, so `lightdm` can't read into it. Both the symlinked greeter config and the wallpaper live under `~`, so without a fix the greeter silently falls back to defaults.

The fix is `chmod o+x` on `~`, `~/dotfiles`, and the `lightdm` dir. That lets `lightdm` traverse to those specific paths without being able to list or read the rest of my home. `install.sh` does this automatically.

## Notes

- The theme isn't tracked here. It's built from source into `/usr/share/themes` by `install.sh`.
- The wallpaper path is `~/Pictures/wall.jpg`, referenced in the greeter config but not included in the repo.
- Apply changes with `sudo systemctl restart lightdm`, which kills the running X session.
