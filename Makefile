.PHONY: clean src

clean:
	@rm -rf src/

src:
	emacs --batch -l org doc/index.org -f org-babel-tangle

tex:
	emacs --batch -l org doc/index.org -f org-latex-export-to-latex

pdf:
	emacs --batch -l org doc/index.org -f org-latex-export-to-pdf
