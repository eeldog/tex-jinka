# Makefile
# (C) 2000 MIYAMOTO Yusuke.
# $Id: Makefile,v 0.2 2000-09-28 15:47:08 yusuke Exp $

## Modify these variables in tune with your site configuration.
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
TEX = platex

## These are specifying install directory.
prefix  = /usr/local
DATADIR = $(prefix)/share
TEXDIR  = $(DATADIR)/texmf/tex
DESTDIR = 

############################################################

all: jinka.cls jpa.sty

jinka.cls: jinka.dtx jinka.ins
	@echo "making class file: jinka" 2>&1
	$(TEX) jinka.ins

jpa.sty: jinka.dtx jpa.ins
	@echo "making package file: jpa" 2>&1
	$(TEX) jpa.ins

doc: 
	@echo "making documents" 2>&1
	$(TEX) jinka.dtx && $(TEX) jinka.dtx

install: all
	$(INSTALL_DATA) -D jinka.cls $(DESTDIR)$(TEXDIR)
	$(INSTALL_DATA) -D jpa.sty   $(DESTDIR)$(TEXDIR)

help:
	@echo "make all        build package files."
	@echo "make doc        make a documentation (dvi format)."
	@echo "make install    install package files."
	@echo "make help       display this message."
	@echo "make clean      delete auxiliary files."
	@echo "make distclean  delete all files which you made."

clean:
	@rm -rf core *~ *.log *.aux *.glo *.blg

distclean: clean
	@rm -rf  jinka.cls jpa.sty jinka.dvi

##EOF
