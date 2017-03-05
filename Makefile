.PHONY: clean clean-cache pdf run-editor src tex

clean:
	@rm -rf src/

clean-cache:
	find . -name "*.pyc" -type f -delete

pdf:
	emacs --batch --script $HOME/.spacemacs -l org doc/index.org -f org-latex-export-to-pdf

run-editor:
	python src/editor.py

src:
	emacs --batch -l org doc/index.org -f org-babel-tangle

tex:
	emacs --batch --script $(HOME)/.spacemacs -l org doc/index.org -f org-latex-export-to-latex
