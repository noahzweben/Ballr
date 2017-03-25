CFLAGS = -Wall -g $(shell sdl2-config --cflags)
#LFLAGS = -framework SDL2
LFLAGS = $(shell sdl2-config --libs)
OBJS   = ballr.o window.o
SAMPLE_GAME = gamec.o
GAME = game.o
PROG = ballr
CXX = clang

all: clean $(PROG)

%.o: %.c
	$(CXX) $(CFLAGS) -c $<

$(PROG): $(OBJS)
	cp ../game.ll .
	clang -c game.ll
	$(CXX) $(OBJS) $(GAME) -o $(PROG) $(LFLAGS)

sample: $(OBJS) $(SAMPLE_GAME)
	$(CXX) $(OBJS) $(SAMPLE_GAME) -o $(PROG) $(LFLAGS)

llvm:
	clang -S -emit-llvm gamec.c

# cleaning everything that can be automatically recreated with "make".
clean:
	rm -f $(PROG) *.o
