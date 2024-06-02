if systemctl --quiet is-active nix.mount; then

	# Source global configuration
	PATH="/nix/var/nix/profiles/default/bin:${PATH}"
	. /nix/var/nix/profiles/default/etc/profile.d/nix.sh 2>/dev/null

	# Set default channels
	NIX_STATE_HOME=${XDG_STATE_HOME-$HOME/.local/state}/nix
	if [ ! -r "${NIX_STATE_HOME}/channels" ]; then
		mkdir -p "${NIX_STATE_HOME}"
		echo 'https://nixos.org/channels/nixpkgs-unstable nixpkgs' > "${NIX_STATE_HOME}/channels"
	fi
	unset NIX_STATE_HOME

fi
