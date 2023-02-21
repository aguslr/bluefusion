[BlueFusion][1]
===============

A custom Fedora Silverblue image that adds RPM Fusion and media codecs.

![Screenshot](https://github.com/aguslr/bluefusion/raw/main/screenshot.png "Screenshot")

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

Verification
------------

These images are signed with Sisgstore's [Cosign][2]. You can verify the
signature by downloading the `cosign.pub` key from this repo and running the
following command:

    cosign verify --key cosign.pub ghcr.io/aguslr/bluefusion

[1]: https://github.com/aguslr/bluefusion
[2]: https://docs.sigstore.dev/cosign/overview/
