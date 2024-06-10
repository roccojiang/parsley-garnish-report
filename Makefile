LATEXMK = latexmk -lualatex -shell-escape

TEX_FILES := $(shell find . -name '*.tex')

all: main.pdf \
	src/introduction/abstract.pdf \
	src/introduction/acknowledgements.pdf \
	src/introduction/introduction.pdf \
	src/background/background.pdf \
	src/background/tools.pdf \
	src/background/parsers.pdf \
	src/body/body.pdf \
	src/body/simple-rules.pdf \
	src/body/leftrec.pdf \
	src/body/impl.pdf \
	src/body/impl/parser.pdf \
	src/body/impl/expr.pdf \
	src/body/complex-rules.pdf \
	src/evaluation/evaluation.pdf \
	src/conclusion/conclusion.pdf \
	src/appendix/appendix.pdf

main: main.pdf

%.pdf: %.tex
	cd $(dir $<) && $(LATEXMK) $(notdir $<)

clean:
	@echo "Cleaning up auxiliary files..."
	@find . -name '*.tex' -exec sh -c 'cd $$(dirname {}) && latexmk -c $$(basename {})' \;
	@find . -type f -name '*.bbl' -exec rm {} +
	@find . -type f -name '*.bbl-SAVE-ERROR' -exec rm {} +
	@find . -type d -name '_minted-*' -exec rm -rf {} +

distclean:
	@echo "Cleaning up all files including PDF outputs..."
	@find . -name '*.tex' -exec sh -c 'cd $$(dirname {}) && latexmk -C $$(basename {})' \;
	@find . -type f -name '*.bbl' -exec rm {} +
	@find . -type f -name '*.bbl-SAVE-ERROR' -exec rm {} +
	@find . -type d -name '_minted-*' -exec rm -rf {} +

.PHONY: all main clean distclean
