FROM ubuntu:14.04.5

MAINTAINER Michael Karlesky <michael@karlesky.net>


# Update Ubuntu package management environment
# Nano is just a convenient text editor for use within the container
# Unzip is unarchives course materials
RUN set -ex \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y nano unzip --no-install-recommends

##
## Development environemnt: compiler toolchain & build tools
##

# Install packages needed for ARM-based cross-compiling
RUN apt-get install -y build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi libglib2.0-0 --no-install-recommends

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
  && rm /var/cache/debconf/*

# When the container launches, drop into a shell
ENTRYPOINT ["/bin/bash"]

