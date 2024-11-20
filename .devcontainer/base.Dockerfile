FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

MAINTAINER Lester Lo <@email>

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required package
RUN ./install_lib.sh

# Create a new user
RUN groupadd build -g 1000
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