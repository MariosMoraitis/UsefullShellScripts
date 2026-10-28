#!/usr/bin/env bash
#
# autoupdate - update DNF packages, Flatpaks and firmware metadata,
# optionally shutting down or rebooting afterwards.

set -uo pipefail

VERSION="0.1.0"
ACTION=""

usage() {
    cat <<EOF
Usage: autoupdate [OPTION]

Update system packages (dnf), Flatpaks, and check for firmware updates.

Options:
  -s, --shutdown   shut down after updating
  -r, --reboot     reboot after updating
  -h, --help       show this help
  -V, --version    show version
EOF
}

for arg in "$@"; do
    case "$arg" in
        -s|--shutdown) ACTION="shutdown" ;;
        -r|--reboot)   ACTION="reboot" ;;
        -h|--help)     usage; exit 0 ;;
        -V|--version)  echo "autoupdate $VERSION"; exit 0 ;;
        *) echo "Unknown option: $arg" >&2; usage >&2; exit 1 ;;
    esac
done

if [[ $EUID -ne 0 ]]; then
    echo "autoupdate must be run as root (try: sudo autoupdate)" >&2
    exit 1
fi

dnf upgrade -y || { echo "dnf upgrade failed, aborting." >&2; exit 1; }
dnf autoremove -y
flatpak update -y
flatpak uninstall --unused -y
fwupdmgr refresh --force || true
fwupdmgr get-updates || true

case "$ACTION" in
    shutdown)
        echo "Updates finished. Shutting down in 1 min (cancel with: shutdown -c)"
        shutdown +1
        ;;
    reboot)
        echo "Updates finished. Rebooting in 1 min (cancel with: shutdown -c)"
        shutdown -r +1
        ;;
esac