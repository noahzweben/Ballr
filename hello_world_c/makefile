CFLAGS = -Wall -g
LFLAGS = -framework SDL2
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
