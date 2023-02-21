[BlueFusion][1]
===============

[![build-ublue](https://github.com/aguslr/bluefusion/actions/workflows/build.yml/badge.svg)](https://github.com/aguslr/bluefusion/actions/workflows/build.yml)

A Fedora Silverblue image that adds RPM Fusion with media codecs and replaces
[Toolbox][2] with [Distrobox][3].

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

These images are signed with Sisgstore's [Cosign][4]. You can verify the
signature by downloading the `cosign.pub` key from this repo and running the
following command:

    cosign verify --key cosign.pub ghcr.io/aguslr/bluefusion

References
----------

- [Building your own custom Fedora Silverblue image][5]
- [Howto/OSTree - RPM Fusion][6]
- [Cosign - Sigstore Documentation][4]
- [Making your Own - Universal Blue][7]


[1]: https://github.com/aguslr/bluefusion
[2]: https://github.com/containers/toolbox
[3]: https://github.com/89luca89/distrobox
[4]: https://docs.sigstore.dev/cosign/overview/
[5]: https://www.ypsidanger.com/building-your-own-fedora-silverblue-image/
[6]: https://rpmfusion.org/Howto/OSTree
[7]: https://ublue.it/making-your-own/
