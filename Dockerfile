FROM ubuntu:14.04.5

MAINTAINER Mike Karlesky <michael@karlesky.net>

ENV DOCKER_PROJECT course2


# Update Ubuntu package management environment
RUN apt-get update
RUN apt-get -y upgrade

# Remove stuff we know we don't need to slim down the environment
RUN apt-get purge -y --auto-remove adduser perl perl-modules whiptail mime-support locales libssl1.0.0 libsqlite3-0 eject logrotate cron cron-daemon initscripts initramfs-tools initramfs-tools-bin xkb-data libtext-wrapi18n-perl libtext-iconv-perl libtext-charwidth-perl


##
## GCC (and some support utilities for later steps)
##

# Install tools needed for final build environment
RUN set -ex \
	&& apt-get install -y nano gcc-arm-none-eabi libnewlib-arm-none-eabi libglib2.0-0 ruby rake --no-install-recommends

# Install tools needed to build Qemu
RUN set -ex \
	&& apt-get install -y gcc python pkg-config build-essential zlib1g-dev libglib2.0-dev --no-install-recommends


##
## Custom Qemu
##

COPY qemu /qemu

RUN set -ex \
  && cd /qemu/qemu-stable-1.1 \
  && ./configure --target-list=arm-softmmu \
  && make \
  && cd /

# Make a /tools directory and copy built Qemu into it
RUN set -ex \
  && mkdir /tools \
  && mv /qemu/qemu-stable-1.1/arm-softmmu/qemu-system-arm /tools

##
## Cleanup
##

RUN apt-get purge -y --auto-remove gcc python pkg-config build-essential libglib2.0-dev zlib1g-dev

RUN set -ex \
  && find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true \
  && find /usr/share/doc -empty|xargs rmdir || true \
  && rm -rf /usr/share/man/* /usr/share/info/*

RUN set -ex \
  && apt-get autoremove \
  && apt-get clean all \
  && apt-get autoclean all

RUN set -ex \
  && rm -rf /qemu

##
## File copying and Path
##

COPY ceedling/ tools/ceedling
COPY unity/ tools/unity
COPY cmock/ tools/cmock

ENV PATH "$PATH:/tools"


# Connect to our external code project
VOLUME ["/surly"]

# When the container launches, start the server
ENTRYPOINT ["/bin/bash"]

