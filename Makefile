# Makefile for RasterInfo.
#
# You need GNU m4 and fonttool's ttx assembler.

.SUFFIXES: .m4 .xml .ttf

.m4.xml:
	m4 < $< > $@

.xml.ttf:
	rm -f $@
	ttx $<

all: RasterInfo.ttf

# EOF
