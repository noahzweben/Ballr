CFLAGS = -Wall -g $(shell sdl2-config --cflags)
OBJS   = ballr.o window.o
PROG = ballr
CXX = clang

lib: $(OBJS)
	mkdir -p build
	ar -rcs build/libblr_rt.a $(OBJS)

all: clean lib

%.o: %.c
	$(CXX) $(CFLAGS) -c $<

# cleaning everything that can be automatically recreated with "make".
clean:
	rm -f $(PROG) *.o	
