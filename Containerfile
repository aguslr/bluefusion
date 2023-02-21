ARG FEDORA_MAJOR_VERSION=37

FROM ghcr.io/aguslr/bluevanilla:${FEDORA_MAJOR_VERSION}

RUN rpm-ostree install distrobox && \
    rpm-ostree override remove toolbox && \
    mkdir -p /etc/distrobox && \
    echo "container_image_default=\"registry.fedoraproject.org/fedora-toolbox:$(rpm -E %fedora)\"" >> /etc/distrobox/distrobox.conf && \
    rpm-ostree cleanup -m && \
    ostree container commit
