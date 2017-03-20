.PHONY: apidoc clean clean-cache htmldoc pdf run-editor src tex

apidoc:
	sphinx-apidoc -f -o doc/source/ src/

clean:
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
	emacs --batch -l org doc/index.org -f org-babel-tangle

tex:
	emacs --batch --script $(HOME)/.spacemacs -l org doc/index.org -f org-latex-export-to-latex
