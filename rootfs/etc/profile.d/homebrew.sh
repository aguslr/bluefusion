if systemctl --quiet is-active var-home-linuxbrew.mount; then
	HOMEBREW_NO_AUTO_UPDATE=1
	export HOMEBREW_NO_AUTO_UPDATE

	# Set environment for interactive shells
	case $- in
		*i*)
			if [ -d ~/.linuxbrew ]; then
				eval "$(~/.linuxbrew/bin/brew shellenv)"
			elif [ -d /home/linuxbrew/.linuxbrew ]; then
				eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
			fi
			;;
	esac
fi
