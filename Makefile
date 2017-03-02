.PHONY: clean src

clean:
	@rm -rf src/

src:
	emacs --batch -l org doc/index.org -f org-babel-tangle
