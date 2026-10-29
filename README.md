# UsefullShellScripts

A small collection of shell scripts for everyday Fedora use. Install once, then run each script as a normal command from any terminal.

## Scripts

| Command | Description |
|---------|-------------|
| [`autoupdate`](#autoupdate) | Update DNF packages and Flatpaks, check for firmware updates, optionally shut down or reboot afterwards |
| [`usb-formatter`](#usb-formatter) | A Python CLI tool to safely list and format USB drives on Linux |

## Installation

### From source

```bash
git clone https://github.com/MariosMoraitis/UsefullShellScripts.git
cd UsefullShellScripts
sudo make install
```

This installs every script from `bin/` into `/usr/bin`. To install somewhere else:

```bash
sudo make install PREFIX=/usr/local
```

### Uninstall

From the same folder:

```bash
sudo make uninstall
```

## Usage

### autoupdate

Runs a full system update in one command:

1. `dnf upgrade` and `dnf autoremove`
2. `flatpak update` and removal of unused Flatpak runtimes
3. Refreshes firmware metadata and lists available firmware updates (it does **not** install them)

```bash
sudo autoupdate              # update only
sudo autoupdate --reboot     # update, then reboot in 1 minute
sudo autoupdate --shutdown   # update, then shut down in 1 minute
```

| Option | Description |
|--------|-------------|
| `-s`, `--shutdown` | Shut down after updating |
| `-r`, `--reboot` | Reboot after updating |
| `-h`, `--help` | Show help |
| `-V`, `--version` | Show version |

Notes:

- Must be run as root (use `sudo`).
- If `dnf upgrade` fails, the script stops and will not reboot or shut down.
- After a reboot or shutdown is scheduled, you can cancel it with `shutdown -c`.
- Firmware updates are only listed, never applied automatically. Install them yourself with `sudo fwupdmgr update`.

### usb-formatter

> A safe and interactive Python CLI tool to list and format USB drives on Linux.
> Confirmation prompt to prevent accidental data loss.
> Select partition to format (fat32, ext4, ntfs)

```bash
sudo usb-formatter
```

## Requirements

- Fedora (or another DNF-based distribution)
- `bash`
- `flatpak` and `fwupd` for the corresponding steps in `autoupdate`

## Adding a new script

1. Put the script in `bin/` without a `.sh` extension, e.g. `bin/my-script`
2. Make it executable: `chmod +x bin/my-script`
3. Lint it: `make lint` (requires `ShellCheck`)
4. Add it to the table in this README

The Makefile installs everything in `bin/` automatically.

## Contributing

Issues and pull requests are welcome. Please run `make lint` before submitting.

## License

See the [LICENSE](LICENSE) file.
