# -*- coding: utf-8 -*-
# vim: autoindent expandtab tabstop=4 sw=4 sts=4 filetype=make

ifdef QDE_DEBUG
NUWEB = nuweb -v -r -l
TEX_VERBOSE =
QDE_DEBUG = QDE_DEBUG=1
else
NUWEB = nuweb -r -l
TEX_VERBOSE = 1> /dev/null
QDE_DEBUG =
endif

JOB = index
BUILD = index
NUWEB_EXT = w
TEX_EXT = tex
AUX_EXT = aux
CLEAN_EXT    := nls,ilg,aux,log,idx,out,glo,toc,lot,tex~,backup,bbl,blg,1,2,3,4,5,6,7,8,9,10,dvi,emp*mp,ooplss*mp,nlo,tdo,dvi,lof,lol,glg,gls,ist,hst,ver,blx.bib,run.xml,$(JOB).pdf
PDFLATEX     := pdflatex
BIBLIOGRAPHY := biber
OS           := $(shell uname)

.PHONY: all build-doc build-doc-fast clean-doc clean-doc-fast doc src watch-build-doc watch-build-doc-fast watch-doc

.build-bibliography:
	$(BIBLIOGRAPHY) $(JOB) ${TEX_VERBOSE}

.build-glossary:
	makeglossaries $(JOB) ${TEX_VERBOSE}

.build-pdflatex:
	$(PDFLATEX) -jobname $(JOB) -shell-escape -interaction=nonstopmode $(BUILD) ${TEX_VERBOSE}

.set-build-to-build-doc-fast:
	$(eval BUILD_COMMAND = build-doc-fast)

.set-build-to-build-doc:
	$(eval BUILD_COMMAND = build-doc)

.set-build-to-doc:
	$(eval BUILD_COMMAND = doc)

.watch-build-command:
ifeq ($(OS), Darwin)
	fswatch -o . -r --include '\.w$$' --exclude '.*' | (while read; do $(QDE_DEBUG) make $(BUILD_COMMAND); done)
else
	while true; do inotifywait -r -e modify --exclude="(.*.lol|.*.lot|.*.lof|.*.toc|.*.tdo|.*.ist|.*.out|.*.pdf|.*.aux|.*.glo|.*.idx|.*.bbl|.*.swp|.*.blg|.*.fdb_latexmk|.*.fls|.*.log)" . && $(QDE_DEBUG) make $(BUILD_COMMAND); done
endif

all: clean-doc build-doc

build-doc:
	rm -f *{$(CLEAN_EXT)}
	rm -f inc/*{$(CLEAN_EXT)}
	rm -rf `$(BIBLIOGRAPHY) --cache`
	${NUWEB} -o $(JOB).$(NUWEB_EXT)
	$(PDFLATEX) -jobname $(JOB) -shell-escape -interaction=nonstopmode $(BUILD) ${TEX_VERBOSE}
	${NUWEB} -o $(JOB).$(NUWEB_EXT)
	$(PDFLATEX) -jobname $(JOB) -shell-escape -interaction=nonstopmode $(BUILD) ${TEX_VERBOSE}
	$(BIBLIOGRAPHY) $(JOB) ${TEX_VERBOSE}
	# makeglossaries $(JOB) ${TEX_VERBOSE}
	$(PDFLATEX) -jobname $(JOB) -shell-escape -interaction=nonstopmode $(BUILD) ${TEX_VERBOSE}

build-doc-fast:
	${NUWEB} -o $(JOB).$(NUWEB_EXT)
	$(PDFLATEX) -jobname $(JOB) -shell-escape -interaction=nonstopmode $(BUILD) ${TEX_VERBOSE}
	${NUWEB} -o $(JOB).$(NUWEB_EXT)

clean-doc:
	rm -f *{$(CLEAN_EXT)}
	rm -f inc/*{$(CLEAN_EXT)}

clean-doc-dist: clean
	@rm -f *.pdf

doc:
	# -o suppresses the generation of (code) files
	${NUWEB} -o $(JOB).$(NUWEB_EXT)

src:
	# -t suppresses the generation of tex files
	${NUWEB} -t -S $(JOB).$(NUWEB_EXT)

watch-build-doc: .set-build-to-build-doc .watch-build-command

watch-build-doc-fast: .set-build-to-build-doc-fast .watch-build-command

watch-doc: .set-build-to-doc .watch-build-command
