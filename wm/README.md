# wm: bspwm desktop

A bspwm desktop themed after Tokyo Night. It uses
[bspwm](https://github.com/baskerville/bspwm) as the window manager, [sxhkd](https://github.com/baskerville/sxhkd)
for hotkeys, [polybar](https://github.com/polybar/polybar) for the bar, [rofi](https://github.com/davatorium/rofi) for the launcher and power menu,
[dunst](https://github.com/dunst-project/dunst) for notifications and the volume/brightness OSD, and [picom](https://github.com/yshui/picom) for
compositing.

> **Super** = the Windows/Mod4 key.

## Keybindings

### Applications & session
| Keys | Action |
| --- | --- |
| `Super + Return` | Terminal (st) |
| `Super + b` | Browser (zen) |
| `Super + x` | cboomer |
| `Super + d` | App launcher (`rofi -show drun`) |
| `Super + r` | Run command (`rofi -show run`) |
| `Super + w` | Window switcher (`rofi -show window`) |
| `Super + Shift + v` | Clipboard history (copyq) |
| `Super + Shift + e` | Power menu (lock/suspend/logout/reboot/shutdown) |
| `Super + Shift + x` | Lock screen |
| `Super + Escape` | Reload sxhkd |
| `Super + Shift + r` | Restart bspwm |
| `Super + Shift + q` | Quit bspwm (log out) |

### Windows
| Keys | Action |
| --- | --- |
| `Super + q` | Close window |
| `Super + h/j/k/l` | Focus window (west/south/north/east) |
| `Super + Shift + h/j/k/l` | Swap window in that direction |
| `Super + f` | Toggle fullscreen |
| `Super + Shift + Space` | Toggle floating |
| `Super + m` | Cycle desktop layout (tiled <-> monocle) |
| `Super + Ctrl + h/j/k/l` | Preselect split direction |
| `Super + Ctrl + Space` | Cancel preselection |
| `Super + Alt + h/j/k/l` | Grow window (expand edge outward) |
| `Super + Alt + Shift + h/j/k/l` | Shrink window (contract edge inward) |
| `Super + Shift + b` | Balance the tree |
| `Super + Shift + , / .` | Rotate the tree -90° / +90° |

### Workspaces
| Keys | Action |
| --- | --- |
| `Super + 1..9` | Switch to workspace 1-9 |
| `Super + 0` | Switch to workspace 10 |
| `Super + Shift + 1..9` | Send window to workspace 1-9 |

### Media & hardware (function keys)
| Keys | Action |
| --- | --- |
| `Volume Up / Down` | Adjust volume (+ OSD) |
| `Mute` | Toggle output mute (+ OSD) |
| `Mic Mute` | Toggle microphone mute |
| `Brightness Up / Down` | Adjust screen brightness (+ OSD) |
| `Play / Pause` | Play/pause media (playerctl) |
| `Next / Prev` | Next / previous track |
| `Stop` | Stop playback |

### Screenshots
| Keys | Action |
| --- | --- |
| `Super + Shift + s` | Screenshot (region) |
| `Super + Shift + d` | Screenshot (full screen) |

### Notifications
| Keys | Action |
| --- | --- |
| `Super + n` | Dismiss current notification |
| `Super + Shift + n` | Dismiss all notifications |
| `Super + Ctrl + n` | Show last dismissed (history) |

## Install

```sh
./install.sh
```

Installs the dependencies (Debian/apt), builds i3lock-color from source (it is
not packaged for Debian; the build happens in a temp dir under `/tmp` and
installs to `/usr/local`), installs the JetBrainsMono Nerd Font, and symlinks
the configs into `~/.config`. Then log into bspwm (or reload a running session
with `bspc wm -r`).

## Layout

| Path | What |
| --- | --- |
| `bspwm/bspwmrc` | Startup: autostart daemons, window rules, monitors |
| `bspwm/lock.sh` | Screen locker (i3lock-color): Tokyo Night ring + clock over a blurred wallpaper |
| `sxhkd/sxhkdrc` | All keybindings |
| `sxhkd/osd.sh` | Volume/brightness OSD (dunst progress bar) |
| `polybar/config-bspwm.ini` | Bar config for bspwm (Tokyo Night) |
| `polybar/config-i3.ini` | Bar config for i3 (Tokyo Night) |
| `rofi/` | Launcher config + `tokyonight.rasi` theme + `powermenu.sh` |
| `dunst/dunstrc` | Notifications + OSD styling |
| `gammastep/config.ini` | Night light temperature (toggled from the bar) |
| `gtk-3.0/settings.ini` | Dark GTK theme |
| `picom/picom.conf` | Compositor |

## Referances

- <https://github.com/baskerville/bspwm>
- <https://github.com/polybar/polybar>
- <https://github.com/baskerville/sxhkd>
- <https://github.com/dunst-project/dunst>
- <https://github.com/davatorium/rofi>
- <https://github.com/yshui/picom>
- <https://github.com/Raymo111/i3lock-color>

## Notes

The night light is toggled manually from the bar: click the moon icon on the
right side to warm the screen on/off. Adjust the warmth via `temp-night` in
`gammastep/config.ini`. The power menu is also on the bar: click the power icon
on the right side.

The lock screen renders the wallpaper (`~/Pictures/wall.jpg`) fit to the primary
output, lightly blurred and darkened, with the Tokyo Night ring and a live clock
on top. Tweak the look in `bspwm/lock.sh`: the `-gaussian-blur` sigma controls
blur strength and `-brightness-contrast` the darkening. Needs `i3lock-color`; it
falls back to a plain solid-color lock if only vanilla i3lock is present.
