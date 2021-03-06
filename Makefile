LATEXCMD="xelatex --shell-escape %O %S"
LATEXMKOPTS=-pdflatex=$(LATEXCMD) -pdf -dvi- -ps- -bibtex
info:
	@echo "Please make a specific target (a4 or c5), or explicitly run \"make all\"."

.PHONY: examples clean-examples mclean-examples distclean-examples
examples:
	$(MAKE) -C examples

mclean-examples:
	$(MAKE) -C examples mostlyclean

clean-examples:
	$(MAKE) -C examples clean

distclean-examples:
	$(MAKE) -C examples distclean

.PHONY: all a4 c5 latexbok-a4.pdf latexbok-c5.pdf
all: latexbok-a4.pdf latexbok-c5.pdf
a4: latexbok-a4.pdf
c5: latexbok-c5.pdf

latexbok-a4.pdf: examples
	latexmk $(LATEXMKOPTS) -jobname=latexbok-a4 -recorder -f a4.tex

latexbok-c5.pdf: examples
	latexmk $(LATEXMKOPTS) -jobname=latexbok-c5 -recorder -f c5.tex

.PHONY: mostlyclean mclean-a4 mclean-c5
mostlyclean: mclean-a4 mclean-c5 mclean-examples

mclean-a4:
	latexmk -c -bibtex -jobname=latexbok-a4 -recorder a4.tex

mclean-c5:
	latexmk -c -bibtex -jobname=latexbok-c5 -recorder c5.tex

.PHONY: clean clean-a4 clean-c5
clean: clean-a4 clean-c5 clean-examples

clean-a4: mclean-a4
	rm -f latexbok-a4-*.cpt *.fls

clean-c5: mclean-c5
	rm -f latexbok-c5-*.cpt *.fls

.PHONY: distclean distclean-a4 distclean-c5
distclean: distclean-a4 distclean-c5 distclean-examples

distclean-a4:
	latexmk -C -bibtex -jobname=latexbok-a4 -recorder a4.tex
	rm -f latexbok-a4-*.cpt *.fls

distclean-c5:
	latexmk -C -bibtex -jobname=latexbok-c5 -recorder c5.tex
	rm -f latexbok-c5-*.cpt *.fls
