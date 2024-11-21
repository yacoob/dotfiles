#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

if ! chezmoi="$(command -v chezmoi)"; then
	bin_dir="${HOME}/.local/bin"
	chezmoi="${bin_dir}/chezmoi"
	echo "Installing chezmoi to '${chezmoi}'" >&2
	if command -v curl >/dev/null; then
		chezmoi_install_script="$(curl -fsSL get.chezmoi.io)"
	elif command -v wget >/dev/null; then
		chezmoi_install_script="$(wget -qO- get.chezmoi.io)"
	else
		echo "To install chezmoi, you must have curl or wget installed." >&2
		exit 1
	fi
	mkdir -p "${bin_dir}"
	sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
	unset chezmoi_install_script bin_dir
fi

set -- init --apply --promptDefaults

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
