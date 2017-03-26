# Ballr
A simple 2D game language


To test Pretty Printing:

(if change anything) 
sh run.bat


./ballr < Ballr\_helloworld/helloworld.blr 

SSH
-------
If ssh-ing into virtual machine, make sure to use -X to enable X-forwarding. Will allow screen to be displayed

Building 
---------
To build a Ballr game, from the root directory type `make <filename>.game  `.
This will build the compiler if it has changed, look for a file called
`<filename>`.blr, use the `ballr` executable to compile this to LLVM, and then
build this LLVM file and link it with the runtime located at runtime/build.


Codegen 
--------
Codegen should be broken down into the following steps:

* entites: To generate the code for entities, each needs a create function and
  a frame function. The create function will take a pointer to the entity as an
  argument, and is responsible for setting the entities given values for size,
  color, et cetera. The frame function is what the events compile to. Every
  frame, the runtime will call each entity's frame function, which checks for
  event conditions and executes the code if needed.

* gameboards: Each gameboard should have a create function and an init
  function. The create function behaves the same as the entity's create func,
  while the init function corresponds directly to the code after the `init =>`
  block in the `gameboard` definition. 

* main(): when generating the main method, we basically create each gameboard
  using that board's create funciton. Then, register\_gb lets the runtime build
  a list of boards keyed by name, so that later (for functions like load()) we
  just refer to boards by their name. After creating the game boards, main()
  calls run\_loop() to start the execution of the game.


Currently, no errors found 
---------------------------


