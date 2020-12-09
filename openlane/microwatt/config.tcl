# SPDX-FileCopyrightText: 2020 Efabless Corporation
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
# SPDX-License-Identifier: Apache-2.0

# Base Configurations. Don't Touch
# section begin
set script_dir [file dirname [file normalize [info script]]]
set ::env(DESIGN_NAME) microwatt
#section end


# User Configurations
set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro.cfg

set ::env(CLOCK_PORT) "ext_clk"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

set ::env(CLOCK_PERIOD) "20"

set ::env(VERILOG_FILES) "\
        $script_dir/../../verilog/rtl/microwatt.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
        $script_dir/../../verilog/rtl/defines.v \
        $script_dir/../../verilog/rtl/DFFRAM.v \
        $script_dir/../../verilog/rtl/DFFRAMBB.v \
        $script_dir/../../verilog/rtl/register_file.v \
        $script_dir/../../verilog/rtl/multiply_4.v \
        $script_dir/../../verilog/rtl/icache.v \
        $script_dir/../../verilog/rtl/dcache.v"

set ::env(EXTRA_LEFS) "\
        $script_dir/../../lef/DFFRAM.lef \
        $script_dir/../../lef/register_file.lef \
        $script_dir/../../lef/multiply_4.lef \
        $script_dir/../../lef/icache.lef \
        $script_dir/../../lef/dcache.lef"

set ::env(EXTRA_GDS_FILES) "\
        $script_dir/../../gds/DFFRAM.gds \
        $script_dir/../../gds/register_file.gds \
        $script_dir/../../gds/multiply_4.gds \
        $script_dir/../../gds/icache.gds \
        $script_dir/../../gds/dcache.gds"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2900 3500"

# Tune
#set ::env(FP_CORE_UTIL) 35
# default 2
#set ::env(CELL_PAD) 4
# default 0.15
#set ::env(GLB_RT_ADJUSTMENT) 0.1
# default 4
#set ::env(SYNTH_MAX_FANOUT) 5
#set ::env(PL_TARGET_DENSITY_CELLS) 0.38

###set ::env(FP_CORE_UTIL) 45
###set ::env(SYNTH_STRATEGY) 2
###set ::env(SYNTH_MAX_FANOUT) 6
###set ::env(GLB_RT_ADJUSTMENT) 0
###set ::env(CELL_PAD) 6

###set ::env(PL_TARGET_DENSITY) [ expr ($::env(FP_CORE_UTIL)+5) / 100.0 ]

###set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

###set ::env(DESIGN_IS_CORE) 0
###set ::env(FP_PDN_CORE_RING) 0
###set ::env(GLB_RT_MAXLAYER) 5

#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(ROUTING_CORES) 8


set ::env(DESIGN_IS_CORE) 0
set ::env(FP_PDN_CORE_RING) 0
set ::env(GLB_RT_MAXLAYER) 5
set ::env(GLB_RT_ADJUSTMENT) 0.1
set ::env(SYNTH_STRATEGY) 2
set ::env(SYNTH_MAX_FANOUT) 6
set ::env(FP_CORE_UTIL) 25
set ::env(PL_TARGET_DENSITY) [ expr ($::env(FP_CORE_UTIL)+5) / 100.0 ]
set ::env(CELL_PAD) 4

#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg
