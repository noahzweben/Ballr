CFLAGS = -Wall -g 
LFLAGS = `/Users/Jessie/Desktop/SDL_PLT/SDL/build/sdl2-config --libs`
OBJS   = ballr.o window.o gamec.o
PROG = ballr
CXX = gcc

%.o: %.c
	$(CXX) $(CFLAGS) -c $<

$(PROG): $(OBJS)
	$(CXX) $(OBJS) -o $(PROG) $(LFLAGS)

llvm:
	clang -S -emit-llvm gamec.c

# cleaning everything that can be automatically recreated with "make".
clean:
	rm $(PROG) *.o
