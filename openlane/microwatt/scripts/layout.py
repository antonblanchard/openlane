#!/usr/bin/python

X=0
Y=1

# Wrapper size
# die_size = (2920, 3520)
# Something that fits within the wrapper
die_size = (2870, 3470)

# Macro sizes
dffram = (750, 525)
icache = (696, 707)
dcache = (785, 795)
multiply_4 = (866, 877)
regfile = (1049, 1060)

# Layout
# DFFRAMS at top
dffram1_l = (150,                           die_size[Y]-dffram[Y]-100)
dffram2_l = (die_size[X]-150-dffram[X],     die_size[Y]-dffram[Y]-100)

# Caches in the middle
icache_l  = (150,                           die_size[Y]-icache[Y]-1110)
dcache_l  = (die_size[X]-150-dcache[X],     die_size[Y]-dcache[Y]-1021)

# Multiply and regfile at bottom
multiply_4_l = (150,                        150)
regfile_l  = (die_size[X]-150-regfile[X],   150)

print("macros")
print("soc0.bram.bram0.ram_0.memory_0 %d %d N" % dffram1_l)
print("soc0.bram.bram0.ram_0.memory_1  %d %d N" % dffram2_l)
print("soc0.processor.icache_0 %d %d N" % icache_l)
print("soc0.processor.dcache_0 %d %d N" % dcache_l)
print("soc0.processor.execute1_0.multiply_0 %d %d N" % multiply_4_l)
print("soc0.processor.register_file_0 %d %d N" % regfile_l)

def keep_out(parms, keepout=5):
    (x0, y0, xs, ys) = parms
    x0 = x0 - keepout
    y0 = y0 - keepout
    x1 = x0 + xs + keepout
    y1 = y0 + ys + keepout
    print("(%d, %d, %d, %d)," % (x0, y0, x1, y1))

print("\nkeep outs")
keep_out(dffram1_l + dffram)
keep_out(dffram2_l + dffram)
keep_out(icache_l + icache)
keep_out(dcache_l + dcache)
keep_out(multiply_4_l + multiply_4)
keep_out(regfile_l + regfile)
