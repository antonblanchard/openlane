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

# update bison
RUN yum -y remove bison
RUN wget https://ftp.gnu.org/gnu/bison/bison-3.0.5.tar.gz && \
    tar -xvzf bison-3.0.5.tar.gz
RUN cd bison-3.0.5 && \
    ./configure --prefix=/usr && \
    make -j$(nproc) && \
    make install

RUN yum remove -y swig \
    && yum install -y pcre-devel \
    && wget https://github.com/swig/swig/archive/rel-3.0.12.tar.gz \
    && tar xfz rel-3.0.12.tar.gz \
    && rm -rf rel-3.0.12.tar.gz \
    && cd swig-rel-3.0.12 \
    && ./autogen.sh && ./configure --prefix=/usr && make -j $(nproc) && make install 

# download CUDD
RUN wget https://www.davidkebo.com/source/cudd_versions/cudd-3.0.0.tar.gz && \
    tar -xvf cudd-3.0.0.tar.gz && \
    cd cudd-3.0.0 && \
    ./configure && \
    make && \
    make install

RUN git clone https://github.com/The-OpenROAD-Project/OpenSTA

WORKDIR OpenSTA

RUN git checkout 6deaf6d8fcabc884063941c3046eb8bdb80061b5

RUN mkdir /build
RUN mkdir build
WORKDIR build
RUN cmake -DCMAKE_INSTALL_PREFIX=/build -DCUDD=/usr/local ..

RUN make -j$(nproc)

RUN mkdir -p /build/bin/ && \
    cp ../app/sta /build/bin

RUN mkdir -p /build/version
RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/opensta.version
RUN git rev-parse HEAD >> /build/version/opensta.version
RUN tar -czf /build.tar.gz /build
