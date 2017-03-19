CFLAGS = -Wall 
LFLAGS = `/Users/Jessie/Desktop/SDL_PLT/SDL/build/sdl2-config --libs`
OBJS   = hello_world.o
PROG = hello_world
CXX = gcc


%.o: main.c
	$(CXX) $(CFLAGS) -c $<

$(PROG): $(OBJS)
	$(CXX) $(OBJS) -o $(PROG) $(LFLAGS)

# cleaning everything that can be automatically recreated with "make".
clean:
	rm $(PROG) *.o
