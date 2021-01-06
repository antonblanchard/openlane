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
FROM openlane-base-build as build

# download public key for github.com
# RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN git clone --recursive https://github.com/kareefardi/OpenDP

RUN mkdir /OpenDP/build
WORKDIR /OpenDP/build

RUN cmake ..

RUN make && \
    make install

RUN mkdir -p /build/bin/ && \
    cp opendp /build/bin

RUN mkdir -p /build/version
RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/opendp.version
RUN git rev-parse HEAD >> /build/version/opendp.version
RUN tar -czf /build.tar.gz /build
