#!/usr/bin/python3
#
# Copyright (C) 2020  Sylvain Munaut <tnt@246tNt.com>
# SPDX-License-Identifier: Apache-2.0
#

import argparse

import opendbpy as odb


# Arguments
parser = argparse.ArgumentParser(
		description='Cleanup XXX')

parser.add_argument('--lef', '-l',
		nargs='+',
		type=str,
		default=None,
		required=True,
		help='Input LEF file(s)')

parser.add_argument('--input-def', '-id', required=True,
		help='DEF view of the design that needs to have its instances placed')

parser.add_argument('--output-def', '-o', required=True,
		help='Output placed DEF file')


args = parser.parse_args()
input_lef_file_names = args.lef
input_def_file_name = args.input_def
output_def_file_name = args.output_def

# Load
db_design = odb.dbDatabase.create()

for lef in input_lef_file_names:
    odb.read_lef(db_design, lef)
odb.read_def(db_design, input_def_file_name)

chip_design = db_design.getChip()
block_design = chip_design.getBlock()
top_design_name = block_design.getName()
print("Design name:", top_design_name)

# ...

LIB_NAME = 'sky130_fd_sc_hd'

WHITELIST = [
	'conb',
	'decap',
	'tapvpwrvgnd',
]

AREAS = [
	# x0, y0, x1, y1
    (100, 2170, 2600, 3370),
    (100, 1390, 780, 2070),
    (2040, 1720, 2770, 2450),
    (100, 100, 900, 900),
    (1570, 100, 2770, 1300),
]

def is_stdcell(i):
	cn =i.getMaster().getName()
	return cn.startswith(LIB_NAME)


def is_stdcell_whitelist(i):
	cn =i.getMaster().getName()
	return cn.split('__')[1].split('_')[0] in WHITELIST


def is_bad_area(i):
	x,y = i.getLocation()

	x /= 1000.0
	y /= 1000.0

	for x0, y0, x1, y1 in AREAS:
		if (x0 <= x <= x1) and (y0 <= y <= y1):
				return True

	return False


def connected_insts(i):
	ci = set()

	for term in i.getITerms():
		net = term.getNet()
		if net is None:
			continue
		for cterm in net.getITerms():
			ci.add(cterm.getInst().getName())

	ci.remove(i.getName())
	b = i.getBlock()

	return [b.findInst(cin) for cin in ci]



insts = block_design.getInsts()

for iterations in range(10):
	r = 0

	for i in insts:
		# Check if it's a std cell and it's not allowed
		if not is_stdcell(i) or is_stdcell_whitelist(i):
				continue

		# Check if it's in the 'bad zone'
		if is_bad_area(i):
			# Fix location of all connected cells
			cil = connected_insts(i)

			xl = []
			yl = []

			for ci in cil:
				if is_bad_area(ci):
					continue

				x, y = ci.getLocation()
				xl.append(x)
				yl.append(y)

			if len(xl) == 0:
				print("ERR", i.getName())
				continue

			# Average position
			x = int(sum(xl) / len(xl))
			y = int(sum(yl) / len(yl))

			# Just pick the first one
			#x = xl[0]
			#y = yl[0]

			(oldx, oldy) = i.getLocation()
			print("Relocating %s %s from %d %d to %d %d" % (i.getName(), i.getMaster().getName(), oldx, oldy, x, y))
			i.setLocation(x, y)

			r += 1

	if r == 0:
		break

print("Done in %d iterations" % iterations)

# Write result
odb.write_def(block_design, output_def_file_name)
