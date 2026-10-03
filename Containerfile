# See https://github.com/RafaelPalomar/citrix_workspace-portable/blob/main/Containerfile for inspiration and original source.

# Using a Ubuntu base image.
FROM docker.io/library/ubuntu:26.04

ARG CITRIX_URL=https://www.citrix.com/downloads/workspace-app/betas-and-tech-previews/workspace-app-tp-for-linux.html
ARG ZOOMVDI_URL=https://zoom.us/download/vdi/7.0.11.27050/zoomvdi-universal-plugin-ubuntu_7.0.11.deb

# Update and install necessary packages. N.B. libopengl0,libxcb-icccm4 are for ZoomVDI
RUN apt-get update && \
    apt-get install -y \
    dbus-x11 gnome-keyring libsecret-tools libcanberra-gtk3-module libpcsclite1 libopengl0 libxcb-icccm4 net-tools dnsutils curl && \
    rm -rf /var/lib/apt/lists/*

# Copying the Citrix ICA client .deb file and installing it.
RUN cd /tmp && \
    curl -LO https:$(curl -L ${CITRIX_URL} | grep icaclient | grep deb | grep amd64 | awk -F 'rel="' '{print $2}' | awk -F '"' '{print $1}')

RUN apt-get update && \
    apt-get install -y /tmp/icaclient*.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/icaclient*.deb

# Copying the Zoom VDI plugin .deb file and installing it.
RUN cd /tmp && \
    curl -LO ${ZOOMVDI_URL}


RUN apt-get update && \
    apt-get install -y /tmp/zoomvdi-universal-plugin*.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/zoomvdi-universal-plugin*.deb
