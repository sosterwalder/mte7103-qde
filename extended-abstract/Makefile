# -*- coding: utf-8 -*-

ifdef QDE_DEBUG
NUWEB = nuweb -v -r -l
TEX_VERBOSE =
TEX_HALT = -halt-on-error
QDE_DEBUG = QDE_DEBUG=1
else
NUWEB = nuweb -r -l
TEX_VERBOSE = 1> /dev/null
TEX_HALT =
QDE_DEBUG =
endif

JOB = index
BUILD = index
NUWEB_EXT = w
TEX_EXT = tex
AUX_EXT = aux
CLEAN_EXT    := nls,ilg,aux,log,idx,out,glo,toc,lot,tex~,backup,bbl,blg,1,2,3,4,5,6,7,8,9,10,dvi,nlo,tdo,dvi,lof,lol,glg,gls,ist,hst,ver,blx.bib,run.xml,$(JOB).pdf
PDFLATEX     := pdflatex
BIBLIOGRAPHY := biber
OS           := $(shell uname)

.PHONY: all bib clean doc doc-fast glossary watch-doc-fast

.pdf:
	$(PDFLATEX) -jobname $(JOB) -shell-escape -interaction=nonstopmode $(TEX_HALT) $(BUILD) ${TEX_VERBOSE}

.set-build-to-doc:
	$(eval BUILD_COMMAND = doc)

.set-build-to-doc-fast:
	$(eval BUILD_COMMAND = doc-fast)

.watch-doc-command:
ifeq ($(OS), Darwin)
	fswatch -o . -r --include '\.w$$' --include '\.bib$$' --include '\.bbl$$' --include '\.tex$$' --exclude '.*' | (while read; do $(QDE_DEBUG) make $(BUILD_COMMAND); done)
else
	while true; do inotifywait -r -e modify --exclude="(.*.lol|.*.lot|.*.lof|.*.toc|.*.tdo|.*.ist|.*.out|.*.pdf|.*.aux|.*.glo|.*.idx|.*.bbl|.*.swp|.*.blg|.*.fdb_latexmk|.*.fls|.*.log)" . && $(QDE_DEBUG) make $(BUILD_COMMAND); done
endif

all:
	$(MAKE) doc

bib:
	$(BIBLIOGRAPHY) $(JOB) ${TEX_VERBOSE}

clean:
	rm -rf `$(BIBLIOGRAPHY) --cache`
	@rm -f *{$(CLEAN_EXT)}
	@rm -f inc/*{$(CLEAN_EXT)}

doc:
	$(MAKE) clean
	$(MAKE) .pdf
	$(MAKE) bib
	$(MAKE) .pdf

doc-fast:
	$(MAKE) .pdf

glossary:
	makeglossaries $(JOB) ${TEX_VERBOSE}

watch-doc-fast: .set-build-to-doc-fast .watch-doc-command
