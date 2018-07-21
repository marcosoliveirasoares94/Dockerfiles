FROM registry.access.redhat.com/rhel6/rhel

MAINTAINER Marcos Oliveira Soares <marcosoliveirasoares94@gmail.com>

LABEL name = "marcosoliveirasoares94/rhel:v1" \
    summary = "Image RedHat with OpenSSH-Server and Supervisor." \
    description = "Image RedHat with OpenSSH-Server and Supervisor." \
    ssh-root-user="root" \
    ssh-root-password="secret"

ENV TERM=xterm
ENV SSH_ROOT_USER=root
ENV SSH_ROOT_PASSWORD=secret
ENV REDHAT_FRONTEND=noninteractive

#
# CentOS/RHEL 6 x86 64bit:
#
COPY conf/centos-6.repo /etc/yum.repos.d/centos-6.repo

#
# BASE image installation.
#
RUN yum install -y \
    vim \
    tar \
    sed \
    curl \
    less \
    nano \
    sudo \
    iproute \
    net-tools \
    python-pip \
    openssh-server \
    openssh-clients \
    python-setuptools \
    #
    # Removing cache Yum
    #
    yum clean all && \
    #
    # Removing packages.
    #
    rm -rf /var/lib/yum/*

# SSH Configuration.
RUN echo "${SSH_ROOT_USER}:${SSH_ROOT_PASSWORD}" | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    /usr/bin/ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N "" && \
    /usr/bin/ssh-keygen -t dsa -b 1024 -f /etc/ssh/ssh_host_dsa_key -N "" && \
    #
    # SSH Configuration Directory.
    #
    mkdir -p /var/run/sshd && \
    #
    # Terminal Configuration.
    #
    echo 'alias ls="ls -a --color=auto"' >> /etc/bashrc && \
    echo 'alias ll="ls -la --color=auto"' >> /etc/bashrc && \
    sed -i 's/env_reset/env_reset,pwfeedback/g' /etc/sudoers && \
    #
    # Creating Symbolic Links.
    #
    ln -s /sbin/ifconfig /bin/ifconfig && \
    ln -s /sbin/route /bin/route

#
# Instalando pip, setuptools e supervisor.
#
RUN easy_install --upgrade pip==9.0.1 && \
    pip install --upgrade supervisor && \
    pip install -U setuptools && \
    #
    # Removing cache Yum.
    #
    yum clean all && \
    #
    # Removing packages.
    #
    rm -rf /var/lib/yum/*

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

# Expose Port.
EXPOSE 22

# Default command.
CMD ["/usr/bin/supervisord"]