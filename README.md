# Ballr
A simple 2D game language.


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
Test


Obligatory Jokes
----------------
Why did the Ballr entity break up with the gameboard?

Because every frame it kept checking for events, but nothing ever collided. 🏀

How does a Ballr developer fix a flat tire?

They just call `create()` again — it's faster than patching the runtime. 🛞

Why did `pong.blr` go to therapy?

Years of being stuck in a `run_loop()`, just bouncing between the same two paddles. 🏓

Why did the LLVM backend refuse to play `flappy.blr`?

It took one look at the codegen and said "I'm not touching that — it's *un-optimizable*." 🐦

What's a Ballr entity's least favorite pickup line?

"Are you a bounding box? Because I feel a collision coming on." 💥

Why was this joke committed directly to master?

Because the repo already has more `add-readme-joke-*` branches than entities, and the punchlines kept failing to merge. 🌳

Why don't Ballr gameboards ever win at poker?

Because every single frame, all their entities show their `create()` functions — they literally can't stop revealing their hands. 🃏

Why did the Ballr entity get kicked out of the gym?

It refused to do anything but `frame` functions — 60 reps per second, zero rest days. 💪

Why do Ballr entities make terrible secret agents?

Because the moment anything happens, they broadcast it as an event — and the whole gameboard gets called about it next frame. 🕵️

Why did the Ballr compiler get invited to every party?

Because it always brings the whole runtime — and it never `make`s a scene unless something changed. 🎉

Why did the Ballr scanner fail its eye exam?

It could only read one token at a time — and it kept seeing things that weren't in the grammar. 👓

Why did the Ballr parser get passed over for the promotion?

Every time leadership gave it something ambiguous, it just shifted instead of reducing. 📉

Why did the semantic analyzer get banned from the comedy club?

It kept stopping every joke halfway through to point out the type errors in the setup. 🎤
