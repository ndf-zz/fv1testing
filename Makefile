# Top-level Makefile for FV-1 test programs
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

TOPTARGETS = program clean
SUBDIRS = $(wildcard */.)
.PHONY: $(TOPTARGETS) $(SUBDIRS)
$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)
