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

FROM centos:centos7 AS openlane-base-build

# Enable epel repo
RUN yum -y --enablerepo=extras install epel-release

# Install Development Environment
RUN yum group install -y "Development Tools" \
    && yum install -y centos-release-scl \
    && yum install -y devtoolset-8 devtoolset-8-libatomic-devel \
    && yum install -y tcl-devel tcl tk libstdc++ tk-devel \
    && yum install -y python3 python3-libs python3-devel python3-pip \
    && yum install -y pcre-devel readline-devel \
    && yum install -y wget \
    yum clean -y all

# centos7 doesn't set the PATH automatically for the installed gcc from dev tools
ENV CC=/opt/rh/devtoolset-8/root/usr/bin/gcc \
    CPP=/opt/rh/devtoolset-8/root/usr/bin/cpp \
    CXX=/opt/rh/devtoolset-8/root/usr/bin/g++ \
    PATH=/opt/rh/devtoolset-8/root/usr/bin:$PATH \
    LD_LIBRARY_PATH=/opt/rh/devtoolset-8/root/usr/lib64:/opt/rh/devtoolset-8/root/usr/lib:/opt/rh/devtoolset-8/root/usr/lib64/dyninst:/opt/rh/devtoolset-8/root/usr/lib/dyninst:/opt/rh/devtoolset-8/root/usr/lib64:/opt/rh/devtoolset-8/root/usr/lib:$LD_LIBRARY_PATH

# install cmake
RUN yum install -y cmake3
RUN alternatives --install /usr/bin/cmake cmake /usr/bin/cmake3 20 
