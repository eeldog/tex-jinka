# Makefile
# $Id: Makefile,v 1.3 2002-02-05 16:40:14 pooh Exp $

PACKAGE = jinka
VERSION = 1.1.2

## Modify these variables in tune with your site configuration.
TEX     = platex -interaction batch
INSTALL = install -c
NKF     = nkf
NKF_JIS = $(NKF) --jis
NKF_MAC = $(NKF) --mac
NKF_WIN = $(NKF) --windows

## These are specifying install directory.
prefix  = /usr/local
datadir = ${prefix}/share
TEXDIR  = ${datadir}/texmf/tex/$(TEX)
DESTDIR = 

SHELL = /bin/sh

PKGFILES = jinka.cls mac/jinka.cls win/jinka.cls jis/jinka.cls \
	jpa.sty	mac/jpa.sty win/jpa.sty jis/jpa.sty \
	jpa.bst mac/jpa.bst win/jpa.bst jis/jpa.bst 
DISTFILES = README Makefile index.html index.html.in jinka.css \
            jinka.ins jinka.dtx jpa.dtx jpa.bst jpa.ins obsolete/sotsu.sty
distdir=$(PACKAGE)-$(VERSION)
# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
all: $(PKGFILES) index.html $(distdir).tar.gz

jinka.cls: jinka.dtx jinka.ins
	@-rm -f $@
	@echo -n "making $@ ... " 1>&2
	@-$(TEX) jinka.ins  1> /dev/null 2>&1
	@echo "done." 1>&2

jpa.sty: jinka.dtx jpa.ins
	@-rm -f $@
	@echo -n "making $@ ..." 1>&2
	@-$(TEX) jpa.ins 1> /dev/null 2>&1
	@echo "done." 1>&2

jpa.bst:
	@echo -n "making $@ ..." 1>&2
	@touch $@
	@echo "done." 1>&2

mac/%: %
	@if [ ! -d mac ]; then \
	  mkdir mac;           \
	fi
	@echo -n "$@: converting kanji code ... " 1>&2
	@$(NKF_MAC) $< > $@ ;
	@echo "done." 1>&2

win/%: %
	@if [ ! -d win ]; then \
	  mkdir win;           \
	fi
	@echo -n "$@: converting kanji code ... " 1>&2
	@$(NKF_WIN) $< > $@ ;
	@echo "done." 1>&2

jis/%: %
	@if [ ! -d jis ]; then \
	  mkdir jis;           \
	fi
	@echo -n "$@: converting kanji code ... " 1>&2
	@$(NKF_JIS) $< > $@ ;
	@echo "done." 1>&2

doc: jinka.dvi

jinka.dvi: jinka.dtx
	@echo -n "making documents ... " 1>&2
	@-$(TEX) jinka.dtx && $(TEX) jinka.dtx
	@echo "done." 1>&2

index.html: index.html.in
	@sed 's,@VERSION@,$(VERSION),g' $< > $@

install: $(PKGFILES)
	@if [ ! -d $(DESTDIR)$(TEXDIR) ]; then             \
	  echo "making directory... $(DESTDIR)$(TEXDIR)";  \
	  mkdir -p $(DESTDIR)$(TEXDIR);                    \
	fi
	@for f in $(PKGFILES); do        \
	  echo -n "install $$f into $(DESTDIR)$(TEXDIR)/$$f ..."; \
          $(INSTALL) -m 644 $$f $(DESTDIR)$(TEXDIR)/$$f;          \
          echo "done." \
	done

clean:
	-rm -f core *~ *.log *.glo *.blg *.aux

distclean: clean
	-rm -f mac/* win/* jinka.cls jpa.sty index.html

$(distdir).tar.gz: distdir
	@chmod -R a+r $(distdir)
	tar cfz $(distdir).tar.gz $(distdir)
	@-rm -rf $(distdir)

distdir: $(DISTFILES)
	@-rm -rf $(distdir)
	mkdir $(distdir)
	@echo -n "copying files ... "
	@for f in $(DISTFILES); do        \
	  $(INSTALL) -D -m 644 $$f $(distdir)/$$f;  \
	done;
	@echo "done."

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
	@echo "  TEX                 LaTeX command. [$(TEX)]"
	@echo "  TEXDIR              directory where files are installed."
	@echo "                        [$(TEXDIR)]"
	@echo ""

version:
	@echo "jinka.cls version $(VERSION)"

.PHONY: all install clean distclean distdir doc help version
# EOF
