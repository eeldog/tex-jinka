# Makefile
# Copyright (C) 2000  MIYAMOTO Yusuke.
# $Id: Makefile,v 0.5 2000-10-01 10:23:49 yusuke Exp $

VERSION = 1.1b

## Modify these variables in tune with your site configuration.
TEX          = platex
INSTALL      = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644

## These are specifying install directory.
prefix  = /usr/local
datadir = ${prefix}/share
TEXDIR  = ${datadir}/texmf/tex/$(TEX)
DESTDIR = 

############################################################
SHELL = /bin/sh

package_files = jinka.cls jpa.sty jpa.bst

all: $(package_files)
doc: jinka.dvi

jinka.cls: jinka.dtx jinka.ins
	@echo "making class file: jinka" 2>&1
	$(TEX) jinka.ins

jpa.sty: jinka.dtx jpa.ins
	@echo "making package file: jpa" 2>&1
	$(TEX) jpa.ins

jinka.dvi: jinka.dtx
	@echo "making documents" 2>&1
	$(TEX) jinka.dtx && $(TEX) jinka.dtx

install: $(package_files)
	@if [ ! -d $(DESTDIR)$(TEXDIR) ]; then               \
        echo "making directory... $(DESTDIR)$(TEXDIR)";  \
        mkdir -p $(DESTDIR)$(TEXDIR);                    \
    fi
	@list='$(package_files)'; for f in $$list; do        \
        echo "install $$f into $(DESTDIR)$(TEXDIR)/$$f"; \
        $(INSTALL_DATA) $$f $(DESTDIR)$(TEXDIR)/$$f;     \
    done

help:
	@echo "Makefile for jinka.cls version $(VERSION)"
	@echo "Usage:"
	@echo "    make all          build package files."
	@echo "    make doc          make a documentation (dvi format)."
	@echo "    make install      install package files."
	@echo "    make help         display this message."
	@echo "    make version      display version infomation."
	@echo "    make clean        delete auxiliary files."
	@echo "    make distclean    delete all files you've made."
	@echo ""
	@echo "Variables:"
	@echo "  TEX                 your LaTeX command"
	@echo "                      [$(TEX)]"
	@echo "  TEXDIR              directory where files are installed."
	@echo "                      [$(TEXDIR)]"
	@echo ""
version:
	@echo "jinka.cls version $(VERSION)"

clean:
	@rm -f core *~ *.log *.aux *.glo *.blg

distclean: clean
	@rm -f jinka.cls jpa.sty jinka.dvi

##EOF
