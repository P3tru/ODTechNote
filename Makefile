MAIN = ODTN

TEXFILES = $(MAIN).tex $(shell ls */*.tex)

PSFILE = $(MAIN).ps
PDFFILE = $(MAIN).pdf
DVIFILE = $(MAIN).dvi

LATEX = pdflatex
BIBTEX = bibtex

REVTEX:=$(CURDIR)/revtex4-1/tex/latex/revtex
REVBST:=$(CURDIR)/revtex4-1/bibtex/bst/revtex
NATBIB:=$(CURDIR)/natbib

export TEXINPUTS:=$(CURDIR):$(REVTEX):$(TEXINPUTS)
export BSTINPUTS:=$(CURDIR):$(REVBST):$(BSTINPUTS)

all : natbib $(MAIN).pdf

revtex:
	mktexlsr $(PWD)/revtex4-1

natbib: $(NATBIB)/natbib.sty

$(NATBIB)/natbib.sty:
	rm natbib.sty; cd $(NATBIB); ls; latex natbib.ins; cd ../; ln -s $(NATBIB)/natbib.sty .

$(MAIN).pdf :$(TEXFILES)
	$(LATEX) -shell-escape $(MAIN) || rm -f $(DVIFILE)
	$(BIBTEX) $(MAIN) || rm -f $(DVIFILE)
	$(LATEX)  $(MAIN) || rm -f $(DVIFILE)
	$(LATEX) $(MAIN) || rm -f $(DVIFILE)

clean:
	$(RM) *~ */*~ $(DVIFILE) $(PSFILE) $(PDFFILE) *.aux *.log *.toc *.bbl *.blg *Notes.bib *.out
