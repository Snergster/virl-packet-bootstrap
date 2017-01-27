FROM ubuntu:16.04
MAINTAINER Ed Kern <ejk@cisco.com>
LABEL Description="VIRL's Ubuntu 16.04 OS base image for packet" Vendor="cisco.com" Version="1.0"


# Setup the environment
ENV DEBIAN_FRONTEND=noninteractive

ADD files/pip /tmp/pip
ADD files/package.list /tmp/package.list
ADD files/packet.apt.conf /etc/apt/apt.conf


# Install packages
RUN rm -f /var/lib/apt/lists/*.lz4 \
    mkdir -p /var/cache/salt/minion/files/base/images/salt \
    apt-get -q update && \
    apt-get -y -qq upgrade && \
    apt-get install -y -qq \
        bash \
        bash-completion \
        bc \
        biosdevname \
        ca-certificates \
        cloud-init \
        cron \
        curl \
        dbus \
        dstat \
        ethstatus \
        file \
        fio \
        htop \
        ifenslave \
        ioping \
        iotop \
        iperf \
        iptables \
        iputils-ping \
        less \
        locate \
        lsb-release \
        lsof \
        make \
        man-db \
        mdadm \
        mg \
        mosh \
        mtr \
        multipath-tools \
        nano \
        net-tools \
        netcat \
        nmap \
        ntp \
        ntpdate \
        open-iscsi \
        python-apt \
        python-pip \
        python-yaml \
        rsync \
        rsyslog \
        screen \
        shunit2 \
        socat \
        software-properties-common \
        ssh \
        sudo \
        sysstat \
        tar \
        tcpdump \
        tmux \
        traceroute \
        unattended-upgrades \
        uuid-runtime \
        vim \
        wget \
    DEBIAN_FRONTEND=noninteractive apt-get install -y $(cat /tmp/package.list) \
    pip install -r /tmp/pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*

#ADD images/* /var/cache/salt/minion/files/base/images/salt

# Configure locales
RUN locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

# Fix permissions
RUN chown root:syslog /var/log \
    && chmod 755 /etc/default

# vim: set tabstop=4 shiftwidth=4:

