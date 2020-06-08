FROM ubuntu:20.04

# General dependencies
RUN apt update && apt upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt install -y tzdata curl wget

# Compiler dependencies
RUN apt install -y python-setuptools cmake build-essential ninja-build python-dev libffi-dev libssl-dev

# Pip & Yotta
WORKDIR /tmp
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py
RUN pip install yotta

# Compiler
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/RC2.1/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2
WORKDIR /opt/compiler
RUN tar -xf  /tmp/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2
ENV PATH="${PATH}:/opt/compiler/gcc-arm-none-eabi-9-2019-q4-major/bin"

# Build directory
RUN mkdir /build
WORKDIR /build

CMD [ "sh", "-c", "yt up && yt build" ]