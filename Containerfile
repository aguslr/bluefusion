ARG FEDORA_MAJOR_VERSION=37

FROM ghcr.io/aguslr/bluevanilla:${FEDORA_MAJOR_VERSION}

RUN rpm-ostree install distrobox && \
    rpm-ostree override remove toolbox && \
    rpm-ostree install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    mkdir -p /etc/distrobox && \
    echo "container_image_default=\"registry.fedoraproject.org/fedora-toolbox:$(rpm -E %fedora)\"" >> /etc/distrobox/distrobox.conf && \
    rpm-ostree cleanup -m && \
    ostree container commit
