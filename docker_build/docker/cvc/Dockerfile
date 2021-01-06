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

FROM openlane-base-build AS build

COPY cvc-1.0.0.tar.gz cvc-1.0.0.tar.gz
RUN tar -xvf cvc-1.0.0.tar.gz

RUN pip3.6 install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir pyinstaller

# Build
WORKDIR cvc-1.0.0
RUN ./configure --disable-nls --prefix=/build && \
    make install

RUN tar -czf /build.tar.gz /build
