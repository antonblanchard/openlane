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
set ::env(DESIGN_NAME) user_project_wrapper
#section end


# User Configurations

## Source Verilog Files
set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_project_wrapper.v \
	$script_dir/../../verilog/rtl/user_proj_example.v"

## Clock configurations
# Should we switch to independent clock?
set ::env(CLOCK_PORT) "mprj.clk"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

set ::env(CLOCK_PERIOD) "20"

## Internal Macros
### Macro Placement
set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro.cfg

### Black-box verilog and views
set ::env(VERILOG_FILES_BLACKBOX) "\
        $script_dir/../../verilog/rtl/RAM_512x64.v \
        $script_dir/../../verilog/rtl/register_file.v \
        $script_dir/../../verilog/rtl/multiply_4.v \
        $script_dir/../../verilog/rtl/icache.v \
        $script_dir/../../verilog/rtl/dcache.v"

set ::env(EXTRA_LEFS) "\
        $script_dir/../../lef/RAM_512x64.lef \
        $script_dir/../../lef/register_file.lef \
        $script_dir/../../lef/multiply_4.lef \
        $script_dir/../../lef/icache.lef \
        $script_dir/../../lef/dcache.lef"

set ::env(EXTRA_GDS_FILES) "\
        $script_dir/../../gds/RAM_512x64.gds \
        $script_dir/../../gds/register_file.gds \
        $script_dir/../../gds/multiply_4.gds \
        $script_dir/../../gds/icache.gds \
        $script_dir/../../gds/dcache.gds"

# The following is because there are no std cells in the example wrapper project.
#set ::env(SYNTH_TOP_LEVEL) 1
#set ::env(PL_RANDOM_GLB_PLACEMENT) 1
#set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0
#set ::env(DIODE_INSERTION_STRATEGY) 0
#set ::env(FILL_INSERTION) 0
#set ::env(TAP_DECAP_INSERTION) 0
#set ::env(CLOCK_TREE_SYNTH) 0

# Temporary, to speed things up
set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

# Tuning
set ::env(GLB_RT_ADJUSTMENT) 0.1
set ::env(SYNTH_STRATEGY) 2
set ::env(SYNTH_MAX_FANOUT) 8
set ::env(PL_TARGET_DENSITY) 0.25
set ::env(CELL_PAD) 6

set ::env(ROUTING_CORES) 8

# DON'T TOUCH THE FOLLOWING SECTIONS

# This makes sure that the core rings are outside the boundaries
# of your block.
set ::env(MAGIC_ZEROIZE_ORIGIN) 0

# Area Configurations. DON'T TOUCH.
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2920 3520"

# Power & Pin Configurations. DON'T TOUCH.
set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_PDN_CORE_RING_VWIDTH) 3
set ::env(FP_PDN_CORE_RING_HWIDTH) $::env(FP_PDN_CORE_RING_VWIDTH)
set ::env(FP_PDN_CORE_RING_VOFFSET) 14
set ::env(FP_PDN_CORE_RING_HOFFSET) $::env(FP_PDN_CORE_RING_VOFFSET)
set ::env(FP_PDN_CORE_RING_VSPACING) 1.7
set ::env(FP_PDN_CORE_RING_HSPACING) $::env(FP_PDN_CORE_RING_VSPACING)

set ::env(FP_PDN_VWIDTH) 3
set ::env(FP_PDN_HWIDTH) 3
set ::env(FP_PDN_VOFFSET) 0
set ::env(FP_PDN_HOFFSET) $::env(FP_PDN_VOFFSET)
set ::env(FP_PDN_VPITCH) 180
set ::env(FP_PDN_HPITCH) $::env(FP_PDN_VPITCH)
set ::env(FP_PDN_VSPACING) [expr 5*$::env(FP_PDN_CORE_RING_VWIDTH)]
set ::env(FP_PDN_HSPACING) [expr 5*$::env(FP_PDN_CORE_RING_HWIDTH)]

set ::env(VDD_NETS) [list {vccd1} {vccd2} {vdda1} {vdda2}]
set ::env(GND_NETS) [list {vssd1} {vssd2} {vssa1} {vssa2}]
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

# Disabled for a reason?
set ::env(RUN_CVC) 0

# Pin Configurations. DON'T TOUCH
set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg
set ::env(FP_DEF_TEMPLATE) $script_dir/../../def/user_project_wrapper_empty.def
set ::unit 2.4
set ::env(FP_IO_VEXTEND) [expr 2*$::unit]
set ::env(FP_IO_HEXTEND) [expr 2*$::unit]
set ::env(FP_IO_VLENGTH) $::unit
set ::env(FP_IO_HLENGTH) $::unit

set ::env(FP_IO_VTHICKNESS_MULT) 4
set ::env(FP_IO_HTHICKNESS_MULT) 4
