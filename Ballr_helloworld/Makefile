CFLAGS = -Wall -g $(shell sdl2-config --cflags) 
LFLAGS = $(shell sdl2-config --libs)
OBJS   = ballr.o window.o game.o
PROG = ballr
CXX = gcc

%.o: %.c
	$(CXX) $(CFLAGS) -c $<

$(PROG): $(OBJS)
	$(CXX) $(OBJS) -o $(PROG) $(LFLAGS)

llvm:
	clang -S -emit-llvm game.c

# cleaning everything that can be automatically recreated with "make".
clean:
	rm $(PROG) *.o
