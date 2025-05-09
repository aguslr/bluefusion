ARG FEDORA_MAJOR_VERSION=41

FROM quay.io/fedora/fedora:${FEDORA_MAJOR_VERSION} AS builder

WORKDIR /tmp
RUN <<-EOT sh
	set -eu

	touch /.dockerenv

	# Install packages
	dnf install -y git xz --setopt=install_weak_deps=False

	# Instal Homebrew
	case "$(rpm -E %{_arch})" in
		x86_64)
			curl -fLs \
				https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -s
			/home/linuxbrew/.linuxbrew/bin/brew update
			;;
		*)
			mkdir /home/linuxbrew
			;;
	esac

	# Add user for nix
	useradd nix
	mkdir -m 0755 /nix && chown nix /nix
EOT

USER nix
RUN <<-EOT sh
	set -eu

	# Install Nix
	curl -fLs https://nixos.org/nix/install | sh -s -- --no-daemon --yes
	cp -pr \
		~/.local/state/nix/profiles/profile-1-link \
		/nix/var/nix/profiles/default
EOT

FROM ghcr.io/aguslr/bluevanilla:${FEDORA_MAJOR_VERSION}

COPY --from=builder --chown=1000:1000 /home/linuxbrew /usr/share/homebrew
COPY --from=builder --chown=1000:1000 /nix /usr/share/nix
COPY rootfs/ /

RUN <<-'EOT' sh
	set -eu

	rpm-ostree install gcc make libxcrypt-compat
	rpm-ostree install distrobox

	rpm-ostree install \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	rpm-ostree install rpmfusion-free-release rpmfusion-nonfree-release \
		--uninstall rpmfusion-free-release \
		--uninstall rpmfusion-nonfree-release

	(rpm-ostree override remove \
		ffmpeg-free \
		libavcodec-free \
		libavdevice-free \
		libavfilter-free \
		libavformat-free \
		libavutil-free \
		libpostproc-free \
		libswresample-free \
		libswscale-free \
		--install=ffmpeg \
		--install=gstreamer1-plugin-libav \
		--install=gstreamer1-plugins-bad-free-extras \
		--install=gstreamer1-plugins-bad-freeworld \
		--install=gstreamer1-plugins-ugly \
		--install=gstreamer1-vaapi) || true

	(rpm-ostree override remove \
		mesa-va-drivers \
		--install=mesa-va-drivers-freeworld \
		--install=mesa-vdpau-drivers-freeworld) || true

	case "$(rpm -E %{_arch})" in
		x86_64)
			rpm-ostree install steam-devices
			rpm-ostree install intel-media-driver libva-intel-driver
			;;
	esac
	rpm-ostree install libva-nvidia-driver

	rpm-ostree cleanup -m && ostree container commit
EOT
