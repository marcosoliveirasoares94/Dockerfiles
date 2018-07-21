FROM debian

MAINTAINER Marcos Oliveira Soares <marcosoliveirasoares94@gmail.com>

LABEL name = "marcosoliveirasoares94/debian:v1.0" \
    summary = "Image Debian with OpenSSH-Server and Supervisor." \
    description = "Image Debian with OpenSSH-Server and Supervisor." \
    ssh-root-user="root" \
    ssh-root-password="secret"

ENV TERM=xterm
ENV SSH_ROOT_USER=root
ENV SSH_ROOT_PASSWORD=secret
ENV DEBIAN_FRONTEND=noninteractive

#
# BASE image installation.
#
RUN apt-get update -y && apt-get install -y \
    vim \
    tar \
    sed \
    curl \
    less \
    sudo \
    nano \
    net-tools \
    apt-utils \
    supervisor \
    iputils-ping \
    openssh-server \
    openssh-client \
    libcurl4-openssl-dev \
    software-properties-common && \
    #
    # Removing outdated software.
    #
    apt-get autoclean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*

#
# SSH Configuration.
#
RUN echo "${SSH_ROOT_USER}:${SSH_ROOT_PASSWORD}" | chpasswd && \
    sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    #
    # SSH Configuration Directory.
    #
    mkdir -p /var/run/sshd && \
    #
    # Terminal Configuration.
    #
    echo 'alias ls="ls -a --color=auto"' >> /etc/bash.bashrc && \
    echo 'alias ll="ls -la --color=auto"' >> /etc/bash.bashrc && \
    sed -i 's/env_reset/env_reset,pwfeedback/g' /etc/sudoers

#
# Solving the error of: Too Many Files Open.
#
COPY conf/sysctl.conf /etc/sysctl.conf
COPY conf/limits.conf /etc/security/limits.conf
COPY conf/90-nproc.conf /etc/security/limits.d/90-nproc.conf

#
# Copy File supervisord.conf
#
COPY conf/supervisord.conf /etc/supervisord.conf

#
# Expose Port.
#
EXPOSE 22

#
# Default command.
#
CMD ["/usr/bin/supervisord"]