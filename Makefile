CFLAGS= -Wall -Wextra -pedantic -std=c99 -Werror -Iinclude/
CPPFLAGS=
LDLIBS=-lm
LDFLAGS=

NNSRC=$(wildcard src/neuralnet/*.c)
NNOBJ=$(NNSRC:.c=.o)

IMGSRC=$(wildcard src/imgprocessing/*.c)
IMGOBJ=$(IMGSRC:.c=.o)

MISCSRC=$(wildcard src/misc/*.c)
MISCOBJ=$(MISCSRC:.c=.o)

GENSRC=$(wildcard src/generate/*.c)
GENOBJ=$(GENSRC:.c=.o)

opti: CFLAGS += -O3
opti: all

debug: CFLAGS += -g
debug: all

all: neuralnet imgprocessing

neuralnet: $(NNOBJ) $(MISCOBJ)
	$(LINK.o) $^ -o $@ $(LDLIBS)

imgprocessing: CPPFLAGS += `pkg-config --cflags sdl`
imgprocessing: LDLIBS += `pkg-config --libs SDL_image`
imgprocessing: $(IMGOBJ) $(MISCOBJ)
	$(LINK.o) $^ -o $@ $(LDLIBS)

.PHONY: doc
doc:
	doxygen doc/doxyconfig
	+$(MAKE) -C doc/latex/
	cp doc/latex/refman.pdf doc/documentation.pdf
	rm -rf doc/latex
	rm -rf doc/html

clean:
	rm -f ./neuralnet
	rm -f ./imgprocessing
	rm -f nn.save
	rm -f $(NNOBJ)
	rm -f $(IMGOBJ)
	rm -f $(MISCOBJ)
	rm -f $(NNSRC:.c=.d)
	rm -f $(IMGSRC:.c=.d)
	rm -f $(MISCSRC:.c=.d)
	rm -f $(GENOBJ)
	rm -f $(GENOBJ:.o=.d)
