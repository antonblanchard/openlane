#!/usr/bin/python

X=0
Y=1

# Wrapper size
# die_size = (2920, 3520)
# Something that fits within the wrapper
die_size = (2870, 3470)

# Macro sizes
dffram = (2500, 900)
icache = (680, 680)
dcache = (730, 730)
multiply_4 = (800, 800)
regfile = (1200, 1200)

# Layout
# DFFRAM at top
dffram1_l = (180,                           die_size[Y]-dffram[Y]-100)

# Caches in the middle
icache_l  = (100,                           die_size[Y]-icache[Y]-1400)
dcache_l  = (die_size[X]-100-dcache[X],     die_size[Y]-dcache[Y]-1250)

# Multiply and regfile at bottom
multiply_4_l = (100,                        100)
regfile_l  = (die_size[X]-100-regfile[X],   100)

print("macros")
print("soc0.bram.bram0.ram_0.memory_0 %d %d N" % dffram1_l)
print("soc0.processor.icache_0 %d %d N" % icache_l)
print("soc0.processor.dcache_0 %d %d N" % dcache_l)
print("soc0.processor.execute1_0.multiply_0 %d %d N" % multiply_4_l)
print("soc0.processor.register_file_0 %d %d N" % regfile_l)

def keep_out(parms, keepout=0):
    (x0, y0, xs, ys) = parms
    x0 = x0 - keepout
    y0 = y0 - keepout
    x1 = x0 + xs + keepout
    y1 = y0 + ys + keepout
    print("(%d, %d, %d, %d)," % (x0, y0, x1, y1))

print("\nkeep outs")
keep_out(dffram1_l + dffram)
keep_out(icache_l + icache)
keep_out(dcache_l + dcache)
keep_out(multiply_4_l + multiply_4)
keep_out(regfile_l + regfile)
