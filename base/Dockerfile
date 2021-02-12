############################################################
# Description: Intel Quartus Prime Lite v20.1.1 Dockerfile #
############################################################

FROM ubuntu:18.04

MAINTAINER m4j0rt0m

# install prerequisite software
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils automake autoconf autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev libtool \
    patchutils bc gawk build-essential bison flex texinfo gperf git openjdk-8-jre python \
    libboost-dev libfl-dev make gcc g++ sed && \
    apt-get clean

# install additional libraries
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libxft2:i386 libxext6:i386 libncurses5:i386 libc6:i386 libstdc++6:i386 unixodbc-dev \
    lib32ncurses5-dev libzmq3-dev \
    gtk2-engines-pixbuf:i386 wget \
    libglib2.0-0 libfreetype6 libtcmalloc-minimal4 && \
    apt-get clean

# install libpng12-0
RUN cd /tmp && \
    wget http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb && \
    apt-get install -y ./libpng12-0_1.2.54-1ubuntu1.1_amd64.deb

# locale stuff
RUN apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8

ENV QUARTUS_INSTALLDIR /opt
ENV QUARTUS_TAR_FILE Quartus-lite-20.1.1.720-linux.tar
ENV QUARTUS_SW_URL https://download.altera.com/akdlm/software/acdsinst/20.1std.1/720/ib_tar/$QUARTUS_TAR_FILE

# download quartus software
RUN cd /tmp && \
    mkdir quartus && \
    cd quartus && \
    wget $QUARTUS_SW_URL && \
    tar -xvf $QUARTUS_TAR_FILE && \
    rm $QUARTUS_TAR_FILE

# install quartus
RUN cd /tmp/quartus && \
    ls -la && \
    ./setup.sh \
      --mode unattended \
      --unattendedmodeui none \
      --disable-components modelsim_ase,modelsim_ae \
      --installdir $QUARTUS_INSTALLDIR \
      --accept_eula 1

# paths
ENV QUARTUS_ROOTDIR $QUARTUS_INSTALLDIR/quartus
ENV QSYS_ROOTDIR $QUARTUS_INSTALLDIR/quartus/sopc_builder/bin
ENV PATH $PATH:$QUARTUS_ROOTDIR/bin:$QSYS_ROOTDIR/bin
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4

# download and install ftdi d2xx driver
#ENV D2XX_DRIVER_URL https://www.ftdichip.com/Drivers/D2XX/Linux/libftd2xx-x86_64-1.4.22.tgz
#RUN cd $DOCK && \
#    mkdir ftdi_d2xx && \
#    cd ftdi_d2xx && \
#    wget $D2XX_DRIVER_URL && \
#    install!

# force the use of bash
RUN ln -sf /bin/bash /bin/sh

WORKDIR /root
