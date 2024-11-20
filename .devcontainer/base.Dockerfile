FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04


SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required package
RUN apt update \
    && apt install -y --no-install-recommends \
    gcc \
    build-essential \
    cmake \
    \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    \chrpath \
    socat \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    python3-subunit \
    zstd \
    liblz4-tool \
    file \
    locales \
    libacl1 \
    libtinfo5 \
    repo

# Create a new user
RUN getent group 1000 || groupadd build -g 1000
RUN useradd -ms /bin/bash -p build build -u 1028 -g 1000 && \
        usermod -aG sudo build && \
        echo "build:build" | chpasswd

# Load the utf-8 locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


USER build
WORKDIR /home/build
RUN git config --global user.email "build@example.com" && git config --global user.name "Build"

# Set the default shell to bash instead of sh
ENV SHELL /bin/zsh