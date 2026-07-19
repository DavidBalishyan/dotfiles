# ly

TUI display manager config, with a Tokyonight-inspired color scheme.

## Files

- `config.ini`: ly daemon config. Tokyonight colors, bspwm session, clock, keybinds.
- `install.sh`: sets this up on a fresh machine.

## Setup

Run `./install.sh`. It installs ly, symlinks the config into `/etc/ly`, creates the agetty symlink if needed, and enables the systemd service.

## Notes

- The config customizes colors to match the Tokyonight palette (`#1A1B26` bg, `#C0CAF5` fg, `#7AA2F7` accent).
- Default session comes from your `.desktop` files in `/usr/share/xsessions/` - ly picks them up automatically.
- Apply changes with `sudo systemctl restart ly@tty2`.
