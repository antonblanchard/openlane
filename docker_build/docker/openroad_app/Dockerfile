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

FROM openlane-base-build AS base-dependencies

RUN yum -y install gettext-devel help2man texinfo

# update bison
RUN yum -y remove bison
RUN wget https://ftp.gnu.org/gnu/bison/bison-3.0.5.tar.gz && \
    tar -xvzf bison-3.0.5.tar.gz
RUN cd bison-3.0.5 && \
    ./configure --prefix=/usr && \
    make -j$(nproc) && \
    make install

# build boost
RUN wget https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.bz2/download && \
    tar -xf download && \
    cd boost_1_72_0 && \
    ./bootstrap.sh && \
    ./b2 install --with-iostreams --with-test -j $(nproc)

# Install SWIG
RUN yum remove -y swig \
    && yum install -y pcre-devel \
    && wget https://github.com/swig/swig/archive/rel-4.0.1.tar.gz \
    && tar xfz rel-4.0.1.tar.gz \
    && rm -rf rel-4.0.1.tar.gz \
    && cd swig-rel-4.0.1 \
    && ./autogen.sh && ./configure --prefix=/usr && make -j $(nproc) && make install \
    && cd .. \
    && rm -rf swig-rel-4.0.1

# eigen required by replace, TritonMacroPlace
RUN git clone https://gitlab.com/libeigen/eigen.git \
    && cd eigen \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make install

RUN cd / && wget http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz \
    && tar -xf lemon-1.3.1.tar.gz \
    && cd lemon-1.3.1 \
    && cmake -B build . \ 
    && cmake --build build -j $(nproc) --target install

RUN git clone https://github.com/westes/flex \
    && cd flex \
    && git checkout v2.6.4 \
    && ./autogen.sh \
    && ./configure \
    && make -j $(nproc) \
    && yum remove -y flex \
    && make install -j $(nproc) \
    && cd - \
    && rm -rf flex

# spdlog required by OpenDB
RUN git clone -b v1.8.1 https://github.com/gabime/spdlog.git \
    && cd spdlog \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make install -j

RUN git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD OpenROAD_22122020
WORKDIR /OpenROAD_22122020/
RUN git checkout ce30b19496d81df2fe97fc78d0929fe497298962 \
	&& git submodule update --init --recursive

COPY rails.patch /OpenROAD_22122020/
RUN git apply rails.patch

COPY setup_local.patch /OpenROAD_22122020/src/OpenDB/src/swig/python
RUN cd /OpenROAD_22122020/src/OpenDB/src/swig/python && git apply setup_local.patch

COPY pdngen_export_subst.patch /OpenROAD_22122020/
RUN git apply pdngen_export_subst.patch

COPY ignore_obs_outside.patch /OpenROAD_22122020/
RUN git apply ignore_obs_outside.patch

COPY opendp-diamond-search.patch /OpenROAD_22122020/
RUN git apply opendp-diamond-search.patch

# Build OpenROAD
RUN mkdir build && mkdir -p /build/version && mkdir install
RUN cd build && cmake -DCMAKE_INSTALL_PREFIX=$(pwd)/install .. && make -j$(nproc)
RUN cd build && make install
RUN cp -r build/install/bin /build/

# OpenDB Python interface
WORKDIR src/OpenDB
RUN mkdir build && mkdir -p /build/version && mkdir install
RUN cd build && cmake -DCMAKE_INSTALL_PREFIX=$(pwd)/install .. && make -j$(nproc) opendbpy
RUN cp -r build/src/swig/python /build/OpenDB_python
WORKDIR /OpenROAD_22122020/

RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/openroad.version
RUN git rev-parse HEAD >> /build/version/openroad.version
RUN tar -czf /build.tar.gz /build
