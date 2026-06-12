MAIN ?= main
BUILD ?= build
JOB ?= $(MAIN)

refresh:
	mktexlsr ~/texmf

build:
	mkdir -p $(BUILD)
	latexmk -xelatex -outdir=$(BUILD) -jobname=$(JOB) $(MAIN).tex
	cp $(BUILD)/$(JOB).pdf ./

clean:
	latexmk -C -outdir=$(BUILD) -jobname=$(JOB) $(MAIN).tex
	rmdir -p $(BUILD) || true
	rm -f $(JOB).pdf

force-build: clean refresh build
