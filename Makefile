INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
TEX = platex

prefix  = /usr/local
DATADIR = $(prefix)/share
TEXDIR  = $(DATADIR)/texmf/tex
DESTDIR = 


all: jinka.cls jjpsy.sty

jinka.cls: jinka.dtx jinka.ins
	@echo "making class file: jinka" 2>&1
	$(TEX) jinka.ins

jjpsy.sty: jjpsy.dtx jjpsy.ins
	@echo "making package file: jjpsy" 2>&1
	$(TEX) jjpsy.ins

doc: 
	@echo "making documents" 2>&1
	$(TEX) jinka.dtx && $(TEX) jinka.dtx
	$(TEX) jjpsy.dtx && $(TEX) jjpsy.dtx

install: all
	$(INSTALL_DATA) -D jinka.cls $(DESTDIR)$(TEXDIR)
	$(INSTALL_DATA) -D jjpsy.sty $(DESTDIR)$(TEXDIR)

clean:
	rm -rf core *~ *.log *.aux *.glo

distclean: clean
	rm -rf  jinka.cls jjpsy.sty jinka.dvi jjpsy.dvi
