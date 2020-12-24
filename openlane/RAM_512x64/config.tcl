set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) RAM_512x64

set ::env(VERILOG_FILES) "\
	$script_dir/src/DFFRAM.v
	$script_dir/src/DFFRAMBB.v
	$script_dir/src/RAM_512x64.v"

set ::env(CLOCK_PORT) "CLK"
set ::env(CLOCK_PERIOD) "10"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

# Not sure why we disable this
set ::env(CLOCK_TREE_SYNTH) 0

# Required because we are using standard cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2800 800"

# Settings for macros
set ::env(DESIGN_IS_CORE) 0
set ::env(FP_PDN_CORE_RING) 0
set ::env(GLB_RT_MAXLAYER) 5

# Handle PDN
set ::env(VDD_NETS) [list {vccd1} {vccd2} {vdda1} {vdda2}]
set ::env(GND_NETS) [list {vssd1} {vssd2} {vssa1} {vssa2}]
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

# Tuning
set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0
set ::env(PL_TARGET_DENSITY) 0.85
set ::env(CELL_PAD) 0
set ::env(DIODE_INSERTION_STRATEGY) 3

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(ROUTING_CORES) 8
