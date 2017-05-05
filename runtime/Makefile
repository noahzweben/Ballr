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

install: lib
	mkdir -p /usr/local/lib
	cp build/libblr_rt.a /usr/local/lib

# cleaning everything that can be automatically recreated with "make".
clean:
	rm -f $(PROG) *.o	
