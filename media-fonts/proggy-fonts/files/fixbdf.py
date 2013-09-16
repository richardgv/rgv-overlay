#! /usr/bin/env python3.2
# -*- coding: utf-8 -*-
# vim:fileencoding=utf-8

import sys, re

# Read BDF source file
if len(sys.argv) < 2 or not sys.argv[1]:
	print("Required parameter not found.", file = sys.stderr)
	sys.exit(1)

bdf = open(sys.argv[1], 'r').read()

def getlinere(name):
	return r"^\s*" + re.escape(name) + r"\s+(.+)\s*$"

def findline(name):
	match = re.search(getlinere(name), bdf, re.MULTILINE | re.IGNORECASE);
	if not match:
		return None
	return match.group(1)

def dropline(name):
	global bdf
	bdf = re.sub(getlinere(name) + r'\n?', "", bdf,
			re.MULTILINE | re.IGNORECASE);

def replaceval(name, rep):
	global bdf
	bdf = re.sub(r"^(\s*" + re.escape(name) + r"\s+).+\s*$", r"\g<1>" + rep, bdf, flags = re.MULTILINE | re.IGNORECASE);

def injectlines(name, inj):
	global bdf
	bdf = re.sub(r"^(\s*" + re.escape(name) + r"\b)", inj + r"\1", bdf, flags = re.MULTILINE | re.IGNORECASE);

# Read FONT line
font = re.search("^\s*FONT\s+-([\w-]+)\s*$", bdf,
		re.MULTILINE | re.IGNORECASE);
if not font:
	print("FONT line not found.", file = sys.stderr)
	sys.exit(2)

font = font.group(1).split('-')
if 14 != len(font):
	print("Incorrect number of elements in FONT.", file = sys.stderr)
	sys.exit(3)

# Add attributes if necessary
extra = list()

if not findline("FACE_NAME"):
	extra.append('FACE_NAME "{}"'.format(font[1]))

if not findline("FAMILY_NAME"):
	extra.append('FAMILY_NAME "{}"'.format(font[1]))

if not findline("WEIGHT"):
	extra.append('WEIGHT "{}"'.format(font[2]))

if not findline("SLANT"):
	extra.append('SLANT "{}"'.format(font[3]))

if not findline("PIXEL_SIZE") and int(font[6]):
	extra.append('PIXEL_SIZE {}'.format(int(font[6])))

if not findline("POINT_SIZE") and int(font[7]):
	extra.append('POINT_SIZE {}'.format(int(font[7])))

if not findline("RESOLUTION_Y") and int(font[9]):
	extra.append('RESOLUTION_Y "{}"'.format(int(font[9])))

if not findline("RESOLUTION_X") and int(font[8]):
	extra.append('RESOLUTION_X {}'.format(int(font[8])))

if not findline("RESOLUTION_Y") and int(font[9]):
	extra.append('RESOLUTION_Y "{}"'.format(int(font[9])))

if not findline("CHARSET_REGISTRY"):
	extra.append('CHARSET_REGISTRY "{}"'.format(font[12].upper()))

if not findline("CHARSET_ENCODING"):
	extra.append('CHARSET_ENCODING "{}"'.format(font[13]))

replaceval("SIZE", "{} {} {}".format(int(font[7]) // 10,
	int(font[8]), int(font[9])))

if extra:
	# Insert all extra lines
	injectlines("ENDPROPERTIES", "\n".join(extra) + "\n")
	# Recalculate the number of properties
	props = re.search(r"STARTPROPERTIES(.|\n)+ENDPROPERTIES", bdf).group(0)
	nprops = len(re.findall("^\s*\S+", props, re.MULTILINE)) - 2
	replaceval("STARTPROPERTIES", str(nprops))

print(bdf)
