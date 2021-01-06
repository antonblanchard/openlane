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

# Install SWIG
RUN yum remove -y swig \
    && wget https://github.com/swig/swig/archive/rel-4.0.1.tar.gz \
    && tar xfz rel-4.0.1.tar.gz \
    && rm -rf rel-4.0.1.tar.gz \
    && cd swig-rel-4.0.1 \
    && ./autogen.sh && ./configure --prefix=/usr && make -j $(nproc) && make install \
    && cd .. \
    && rm -rf swig-rel-4.0.1

# Installing boost for build dependency
RUN wget https://dl.bintray.com/boostorg/release/1.68.0/source/boost_1_68_0.tar.bz2 && \
    tar -xf boost_1_68_0.tar.bz2 && \
    cd boost_1_68_0 && \
    ./bootstrap.sh -with-libraries=program_options,log,filesystem && \
    ./b2 -j$(nproc) install
 
RUN git clone --recursive https://github.com/scale-lab/OpenPhySyn.git && \
    cd OpenPhySyn && \
    git checkout 6bb80c5f9312a302b7c29cf1a4ddb93ace47d122 
    
# Build
WORKDIR OpenPhySyn
RUN mkdir build && mkdir /build
RUN cd build && cmake .. -DCMAKE_BUILD_TYPE=release && make -j 4 && make install
RUN mkdir /build/bin && cp build/Psn /build/bin/

RUN mkdir -p /build/version
RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/openphysyn.version
RUN git rev-parse HEAD >> /build/version/openphysyn.version
RUN tar -czf /build.tar.gz /build
