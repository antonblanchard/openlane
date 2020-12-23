#!/usr/bin/python

X=0
Y=1

# Wrapper size
die_size   = (2920, 3520)

# Macro sizes
dffram     = (2500,  900)
icache     = ( 680,  680)
dcache     = ( 730,  730)
multiply_4 = ( 800,  800)
regfile    = (1000, 1000)

# Macro layout

# DFFRAM at top
dffram1_l    = (180,                          die_size[Y]-dffram[Y]-50)

# Caches in the middle
icache_l     = (50,                           die_size[Y]-icache[Y]-1400)
dcache_l     = (die_size[X]-50-dcache[X],     die_size[Y]-dcache[Y]-1250)

# Multiply and regfile at bottom
multiply_4_l = (50,                           50)
regfile_l    = (die_size[X]-50-regfile[X],    50)

print("microwatt_0.soc0.bram.bram0.ram_0.memory_0       %4d %4d N" % dffram1_l)
print("microwatt_0.soc0.processor.icache_0              %4d %4d N" % icache_l)
print("microwatt_0.soc0.processor.dcache_0              %4d %4d N" % dcache_l)
print("microwatt_0.soc0.processor.execute1_0.multiply_0 %4d %4d N" % multiply_4_l)
print("microwatt_0.soc0.processor.register_file_0       %4d %4d N" % regfile_l)
