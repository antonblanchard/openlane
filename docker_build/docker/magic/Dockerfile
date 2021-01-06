# Copyright 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# syntax = docker/dockerfile:1.0-experimental
FROM openlane-base-build AS build

# magic dependencies
RUN yum install -y mesa-libGLU-devel csh libX11-devel cairo-devel ncurses-devel

# git clone magic components
RUN git clone git://opencircuitdesign.com/magic magic_06012021

WORKDIR magic_06012021

RUN git checkout 5005f77d3fb1d77eb71d58c85f36ddbefecb0c09

# build
RUN CFLAGS="-O2 -g" ./configure --prefix=/build && \
    make -j$(nproc) && \
    make install

RUN mkdir -p /build/version/

RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/magic.version
RUN git rev-parse HEAD >> /build/version/magic.version
RUN tar -czf /build.tar.gz /build
