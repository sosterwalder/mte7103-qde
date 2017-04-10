.PHONY: apidoc clean clean-cache htmldoc pdf run-editor src tex

apidoc:
	sphinx-apidoc -f -o doc/source/ src/

clean: clean-src

clean-src:
	@rm -rf src/

clean-cache:
	find . -name "*.pyc" -type f -delete

clear-screen:
	@clear

htmldoc: apidoc
	make -C doc html
	open doc/build/html/index.html

ide:
	emacs doc/index.org &

pdf: tex
	latexmk --shell-escape -pdf -xelatex doc/index.tex

run-editor: clean-cache clear-screen
	python src/editor.py

src:
	make -C doc src

tex:
	emacs --batch -l /Users/so/repos/orgmk/lisp/org-latex-classes.el -l org doc/index.org -f org-latex-export-to-latex --kill
