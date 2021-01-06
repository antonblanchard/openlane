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

RUN yum install -y libxml2-devel libxslt-devel zlib-static glibc-static bzip2

# Install SWIG
RUN wget http://prdownloads.sourceforge.net/swig/swig-4.0.0.tar.gz && \
    tar -xf swig-4.0.0.tar.gz && \
    cd swig-4.0.0 && \
    ./configure && \
    make -j$(nproc) && \
    make install

# Installing boost for build dependency
RUN wget https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.bz2/download && \
    tar -xf download && \
    cd boost_1_72_0 && \
    ./bootstrap.sh && \
    ./b2 install --with-iostreams --with-test link=shared -j $(nproc)

# download public key for github.com
#RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN git clone https://github.com/The-OpenROAD-Project/TritonRoute.git TritonRoute_26102020 \
	&& cd TritonRoute_26102020 \
	&& git checkout a639a8b8c99fb078057d8449aa57333952b06309

RUN mkdir TritonRoute_26102020/build

WORKDIR TritonRoute_26102020/build

RUN cmake ../
RUN make -j$(nproc)

RUN mkdir -p /build/bin/ && \
    cp TritonRoute /build/bin/TritonRoute

RUN mkdir -p /build/version
RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/route_14.version
RUN git rev-parse HEAD >> /build/version/route_14.version
RUN tar -czf /build.tar.gz /build

