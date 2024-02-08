#!/bin/bash
# shellcheck disable=2162

# -e: exit on error
# -u: exit on unset variables
set -eu
force=false

while [ $# -gt 0 ]; do
	case "$1" in
	-f | --force)
		force=true
		;;
	esac
	shift
done

function confirm() {
	if $force -eq true; then
		return 0
	fi
	while true; do
		read -p "$1 " yn
		case $yn in
		[Yy]*) return 0 ;;
		[Nn]*) return 1 ;;
		[Cc]*) exit ;;
		*) echo "Please answer YES, NO, or CANCEL." ;;
		esac
	done
}

if ! chezmoi="$(command -v chezmoi)"; then
	if confirm "Chezmoi not found, install it? [yYnN]"; then
		bin_dir="/usr/bin"
		chezmoi="${bin_dir}/chezmoi"
		echo "Installing chezmoi to '${chezmoi}'" >&2

		# Requirements - Debian based apt stuff
		if command -v apt-get >/dev/null; then
			if [ "$EUID" -ne 0 ]; then
				if command -v sudo >/dev/null; then
					echo "running apt-get update, with sudo"
					sudo apt-get update >/dev/null
					echo "running apt-get install git curl, with sudo"
					sudo apt-get install -y git curl vim >/dev/null
				else
					echo "sudo not available"
				fi
			else
				echo "running apt-get update"
				apt-get update >/dev/null
				echo "running apt-get install git curl"
				apt-get install -y git curl vim >/dev/null
			fi
		fi

		# continue
		if command -v curl >/dev/null; then
			chezmoi_install_script="$(curl -fsSL get.chezmoi.io)"
		elif command -v wget >/dev/null; then
			chezmoi_install_script="$(wget -qO- get.chezmoi.io)"
		else
			echo "To install chezmoi, you must have curl or wget installed." >&2
			exit 1
		fi
		if [ "$EUID" -ne 0 ]; then
			if command -v sudo >/dev/null; then
				sudo sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
				unset chezmoi_install_script bin_dir
			else
				echo "sudo not available to install chezmoi in ${bin_dir}"
				exit 1
			fi
		else
			sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
			unset chezmoi_install_script bin_dir
		fi
	else
		echo "Installation canceled."
		exit 1
	fi
fi

if chezmoi="$(command -v chezmoi)"; then
	# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
	# script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
	# set -- init --apply --source="${script_dir}"
	# echo "Running 'chezmoi $*'" >&2
	# exec "$chezmoi" "$@"
	# exec: replace current process with chezmoi
	if $force -eq true; then
		echo "Skipping key due to force"
	elif confirm "You want to add a encryption key? [yYnN] "; then
		kpath="$HOME/.config/chezmoi"
		kfile="$kpath/key.txt"
		mkdir -p "$kpath"
		read -s -p "KEY (paste): " key
		printf "\n>>> saved %s" "$kfile"
		echo "$key" >"$kfile"
		chmod 0600 "$kfile"
	fi

	if confirm "Initialize dotfiles in $HOME? [yYnN] "; then
		if [ -d ~/.local/share/chezmoi/.git ]; then
			chezmoi update --apply
		else
			cd "$HOME"
			chezmoi init --apply https://github.com/zerolith/dotfiles.git # || chezmoi purge --force
		fi
	else
		echo "Will not initialize, script exiting."
		exit 1
	fi
fi
