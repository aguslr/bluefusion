[BlueFusion][1]
===============

A custom Fedora Silverblue image that adds RPM Fusion and media codecs.

Usage
-----

    sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/aguslr/bluefusion:latest

Features
--------

- Start with a custom Fedora Silverblue image.
- Replace `toolbox` with `distrobox`.
- Add RPM Fusion repositories and several multimedia packages.
- Add keyboard shortcuts:
  + Open Terminal into the system's shell: `<Control><Alt>t`
  + Open Terminal into the default Distrobox container: `<Super>Return`

[1]: https://github.com/aguslr/bluefusion
