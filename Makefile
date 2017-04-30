.PHONY: apidoc clean clean-cache doc htmldoc pdf run-editor src tex

apidoc:
	sphinx-apidoc -f -o doc/source/ src/

clean: clean-src

clean-src:
	@rm -rf src/

clean-cache:
	find . -name "*.pyc" -type f -delete

clear-screen:
	@clear

doc:
	make -C doc/ build-doc

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
	make -C doc/ doc
