# Makefile

PACKAGE = jinka
VERSION = 1.2.3

## Modify these variables in tune with your site configuration.
TEX      = platex
TEXFLAGS = -interaction batch
INSTALL  = install -c
DVIPDF   = dvipdfmx
NKF      = nkf
NKF_JIS  = $(NKF) --jis
NKF_MAC  = $(NKF) --mac
NKF_WIN  = $(NKF) --windows

## These are specifying install directory.
prefix   = /usr/local
datadir  = ${prefix}/share
TEXDIR   = ${datadir}/texmf/tex/$(TEX)
DESTDIR  = 

SHELL = /bin/sh

PKGFILES = jinka.cls japa.sty japa.bst english.sty summary.cls
DISTFILES = README Makefile index.html index.html.in jinka.css \
            jinka.cls jinka.dtx jinka.ins summary.cls \
            japa.sty japa.dtx japa.bst japa.ins \
            english.sty obsolete/sotsu.sty jinka.spec

distdir=$(PACKAGE)-$(VERSION)

################################################################
all: $(PKGFILES) index.html

jinka.cls: jinka.dtx jinka.ins
	@-rm -f $@
	@echo -n "making $@ ... " 1>&2
	@-$(TEX) $(TEXFLAGS) jinka.ins  1> /dev/null 2>&1
	@cp $@ $@.bak; nkf -j $@.bak > $@;
	@echo "done." 1>&2

japa.sty: japa.dtx japa.ins
	@-rm -f $@
	@echo -n "making $@ ..." 1>&2
	@-$(TEX) $(TEXFLAGS) japa.ins 1> /dev/null 2>&1
	@echo "done." 1>&2

japa.bst:
	@echo -n "making $@ ..." 1>&2
	@touch $@
	@echo "done." 1>&2

doc: jinka.dvi

jinka.dvi: jinka.dtx
	@echo -n "making documents ... " 1>&2
	@-$(TEX) $(TEXFLAGS) jinka.dtx && $(TEX) $(TEXFLAGS) jinka.dtx
	@echo "done." 1>&2

jinka.pdf: jinka.dvi
	$(DVIPDF) $<

 jinka.spec: jinka.spec.in
	@sed 's,@VERSION@,$(VERSION),g' $< > $@

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
	-rm -f jinka.cls japa.sty index.html

package: $(distdir).tar.gz

$(distdir).tar.gz: distdir
	@chmod -R a+r $(distdir)
	tar cfz $(distdir).tar.gz $(distdir)
	rm -rf $(distdir)

distdir: $(DISTFILES)
	@-rm -rf $(distdir)
	mkdir $(distdir)
	@echo -n "copying files ... "
	@for f in $(DISTFILES); do        \
	  $(INSTALL) -m 644 $$f $(distdir)/$$f;  \
	done;
	@echo "done."

help:
	@echo "Makefile for jinka.cls version $(VERSION)"
	@echo "Usage:"
	@echo "    make all          build package files."
	@echo "    make doc          make a documentation (dvi format)."
	@echo "    make install      install package files."
	@echo "    make package      pack up a tarball."
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

.PHONY: all install clean distclean package distdir doc help version
