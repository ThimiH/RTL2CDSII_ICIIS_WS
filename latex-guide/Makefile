TEX = latexmk
TEXFLAGS = -pdf -interaction=nonstopmode -file-line-error

MAIN = main.tex

.PHONY: all clean

all:
	$(TEX) $(TEXFLAGS) $(MAIN)

clean:
	$(TEX) -c $(MAIN)
	rm -f *.fls *.fdb_latexmk
