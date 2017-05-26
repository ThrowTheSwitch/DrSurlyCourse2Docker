FROM ubuntu:14.04.5

MAINTAINER Michael Karlesky <michael@karlesky.net>


# Update Ubuntu package management environment
# Nano is just a convenient text editor
RUN set -ex \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y nano --no-install-recommends


##
## Environemnt set up
##

RUN mkdir /tools
ENV PATH "$PATH:/tools"


##
## Custom Qemu for ARM emulation
##

COPY qemu /qemu

# Install tools needed to build Qemu
RUN apt-get install -y gcc python pkg-config build-essential libglib2.0-dev --no-install-recommends

# Build Qemu
RUN set -ex \
  && cd /qemu/qemu-stable-1.1 \
  && ./configure --target-list=arm-softmmu --disable-docs --disable-pie --disable-usb-redir --disable-guest-base --disable-slirp --disable-nptl --disable-blobs --audio-drv-list="" --audio-card-list="" --disable-linux-aio --disable-curl --disable-curses --disable-zlib-test \
  && make \
  && cd /
  
# Copy built Qemu into tools directory
RUN mv /qemu/qemu-stable-1.1/arm-softmmu/qemu-system-arm /tools

# Cleanup
RUN set -ex \
  # Remove Qemu source directory
  && rm -rf /qemu \
  # Remove packages needed to build Qemu
  && apt-get purge -y --auto-remove gcc python pkg-config build-essential libglib2.0-dev
  

##
## Development environemnt: compiler toolchain & build tools
##

# Install packages needed for ARM-based cross-compiling
RUN apt-get install -y gcc-arm-none-eabi libnewlib-arm-none-eabi libglib2.0-0 --no-install-recommends

# Install Ruby & Ceedling, CMock, Unity
RUN set -ex \
  && apt-get install -y ruby --no-install-recommends \
  # Prevent documentation installation taking up space
  && echo "gem: --no-ri --no-rdoc" > ~/.gemrc \
  # Get Ceedling, Unity, CMock
  && gem install ceedling \
  && cd /tmp \
  # Extract and move tools
  && ceedling new project \
  && mv project/vendor/ceedling /tools \
  && cd / \
  && rm -rf /tmp/*

##
## Cleanup
##
RUN set -ex \
  # Clean up apt-get leftovers and package lists
  && apt-get autoremove \
  && apt-get clean all \
  && apt-get autoclean all \
  && rm -rf /var/lib/apt/lists/* \
  # Unneeded Debconf templates
  && rm /var/cache/debconf/* \
  # Thin out arm-none-eabi install, removing tools we don't need
  && rm /usr/bin/arm-none-eabi-addr2line \
  && rm /usr/bin/arm-none-eabi-ar \
  && rm /usr/bin/arm-none-eabi-c++ \
  && rm /usr/bin/arm-none-eabi-c++filt \
  && rm /usr/bin/arm-none-eabi-cpp \
  && rm /usr/bin/arm-none-eabi-elfedit \
  && rm /usr/bin/arm-none-eabi-gcc-ar \
  && rm /usr/bin/arm-none-eabi-gcc-nm \
  && rm /usr/bin/arm-none-eabi-gcc-ranlib \
  && rm /usr/bin/arm-none-eabi-gcov \
  && rm /usr/bin/arm-none-eabi-gprof \
  && rm /usr/bin/arm-none-eabi-objcopy \
  && rm /usr/bin/arm-none-eabi-objdump \
  && rm /usr/bin/arm-none-eabi-ranlib \
  && rm /usr/bin/arm-none-eabi-readelf \
  && rm /usr/bin/arm-none-eabi-size \
  && rm /usr/bin/arm-none-eabi-strings \
  && rm /usr/bin/arm-none-eabi-strip

# Connect to our external code project
VOLUME ["/surly"]

# When the container launches, drop into a shell
ENTRYPOINT ["/bin/bash"]

