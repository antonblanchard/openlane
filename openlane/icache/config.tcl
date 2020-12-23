set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) icache

set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/icache.v"

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "20"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 660 660"

# Settings for macros
set ::env(DESIGN_IS_CORE) 0
set ::env(FP_PDN_CORE_RING) 0
set ::env(GLB_RT_MAXLAYER) 5

# Handle PDN
set ::env(VDD_NETS) [list {vccd1} {vccd2} {vdda1} {vdda2}]
set ::env(GND_NETS) [list {vssd1} {vssd2} {vssa1} {vssa2}]
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

# Tuning
set ::env(GLB_RT_ADJUSTMENT) 0.1
set ::env(SYNTH_STRATEGY) 2
set ::env(SYNTH_MAX_FANOUT) 6
set ::env(PL_TARGET_DENSITY) 0.55
#set ::env(CELL_PAD) 4

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(ROUTING_CORES) 8
