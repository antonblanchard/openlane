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

RUN yum -y install ninja-build

RUN git clone https://github.com/ax3ghazy/padring \
	&& cd padring \
        && git checkout a88faf5a4faef75ff241276599fef81c3653cb70

WORKDIR padring

RUN ./bootstrap.sh && cd build/ && ninja-build && mkdir /build/bin/ -p && cp padring /build/bin

RUN mkdir -p /build/version
RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/padring.version
RUN git rev-parse HEAD >> /build/version/padring.version
RUN tar -czf /build.tar.gz /build
