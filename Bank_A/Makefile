# Makefile for FV-1 test program bank
#
# --
# 2018 Nathan Fraser <ndf@metarace.com.au>
#
# To the extent possible under law, the author(s) have dedicated
# all copyright and related and neighboring rights to this software
# to the public domain worldwide. This software is distributed
# without any warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software. If not, see:
#
#   http://creativecommons.org/publicdomain/zero/1.0/
# --
#

# Bank file and information strings
BANKFILE = banka
BANKNAME = "A: Load / Initialise"

# Dervish bank number to write to
BANKNO = 0	

# FV-1 assembler and flags
AS = asfv1
ASFLAGS = -b
DIS = disfv1
DISFLAGS =

# Helper script for extracting Dervish display texts
DRVTXT = ../scripts/drvtext

# i2c eeprom programmer
PGM = fv1-eeprom-host
PGMTTY = /dev/ttyACM2
PGMFLAGS = -p 128 -n 4789 -t $(PGMTTY)

# --
TARGET = $(addsuffix .bin,$(BANKFILE))
CHECKFILE = $(TARGET:.bin=.chk)
DRVBANK = $(TARGET:.bin=.bnk)
SOURCES = $(wildcard [01234567]_*.asm)
LISTINGS = $(SOURCES:.asm=.lst)
DRVTXTS = $(SOURCES:.asm=.dvt)

.PHONY: bank
bank:	$(DRVBANK)

$(TARGET):	$(LISTINGS)

$(DRVBANK): $(TARGET) $(DRVTXTS)
	dd if=$(TARGET) bs=512 count=8 conv=notrunc of=$(DRVBANK)
	printf '%-20.20b\n' $(BANKNAME) \
		| dd bs=21 count=1 seek=4096 oflag=seek_bytes conv=notrunc of=$(DRVBANK)
	
%.dvt: %.asm
	$(DRVTXT) $< $@
	dd if=$@ bs=84 count=1 seek=$(shell echo $$(( 4117 + $(firstword $(subst _, ,$<)) * 84 ))) oflag=seek_bytes conv=notrunc of=$(DRVBANK)

%.lst: %.asm
	$(AS) $(ASFLAGS) -p $(firstword $(subst _, ,$<)) $< $(TARGET)
	$(DIS) $(DISFLAGS) -p $(firstword $(subst _, ,$<)) $(TARGET) $@

.PHONY: $(CHECKFILE)
$(CHECKFILE):
	$(PGM) $(PGMFLAGS) -o $(shell echo $$(( 5120 * $(BANKNO) ))) -f $(CHECKFILE) -c R

.PHONY: verify
verify: $(DRVBANK) $(CHECKFILE)
	cmp -b $(CHECKFILE) $(DRVBANK)
	@echo Verify OK

.PHONY: program
program: $(DRVBANK)
	$(PGM) $(PGMFLAGS) -o $(shell echo $$(( 5120 * $(BANKNO) ))) -f $(DRVBANK) -c W
	$(PGM) $(PGMFLAGS) -o $(shell echo $$(( 5120 * $(BANKNO) ))) -f $(CHECKFILE) -c R
	cmp -b $(CHECKFILE) $(DRVBANK)
	@echo Program OK

.PHONY: help
help:
	@echo
	@echo Targets:
	@echo "	bank [default]	assemble sources into a dervish bank file"
	@echo "	program		program bank on a dervish via i2c"
	@echo "	verify		verify bank on a dervish via i2c"
	@echo "	clean		remove all intermediate files"
	@echo

.PHONY: clean
clean:
	-rm -f $(TARGET) $(CHECKFILE) $(DRVBANK) $(LISTINGS) $(DRVTXTS)
