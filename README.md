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

Why does the Ballr codegen never get lost on road trips?

Because no matter where it's going, it always follows the IR — and if the route looks rough, it just lets LLVM optimize it away. 🗺️

Why is the Ballr linker so popular at office parties?

It's great at resolving everyone's external conflicts — as long as each one is defined exactly once. 🔗

Why does the Ballr runtime never get any sleep?

Because the moment it finally settles down, some gameboard yells "next frame!" — sixty times a second, every second, forever. 😴

Why did the Ballr entity refuse to leave the couch?

It heard there was a `load()` involved, and it wasn't about to switch gameboards for that. 🛋️

Why did the Ballr collision detector make a terrible roommate?

No matter how much space you gave it, it always insisted your bounding boxes were overlapping. 📦

Why does the Ballr AST never get invited to family reunions?

Every time someone asks about its children, it insists on a full depth-first traversal — and won't stop until it's visited every single leaf. 🌲

Why did `testall.sh` get promoted to management?

It never writes any code itself — it just watches everyone else run and reports who failed. 📋

Why do Ballr entities make the best improv partners?

Whatever happens, they always respond in the same frame — and they never break character, because `create()` only runs once. 🎭

Why did the Ballr garbage collector get kicked out of the museum?

It kept insisting that anything without a reference was trash. 🗑️

Why does the Ballr symbol table make the best bartender?

It never forgets a name — but the second you leave its scope, it acts like it's never seen you before. 🍸

Why did the Ballr lexer break up with its keyboard?

Too many unrecognized characters in the relationship. ⌨️

Why did the Ballr Makefile go to couples counseling?

Because every time its partner changed even a little, it rebuilt everything from scratch instead of talking about it. 🔨

Why do Ballr developers always ssh with `-X`?

Because without X-forwarding, playtesting is just staring at a terminal and taking the collision detector's word for it. 🖥️

Why did the Ballr parser refuse to go on a second date?

It hit an unexpected token and couldn't recover. 💔

Why did the Ballr entity fail its driving test?

It only knows how to move once per frame — and it treats every stop sign as a collision event. 🚗

Why did `angrybird.blr` never pass code review?

Because its entire architecture was just one entity getting launched at a wall until something broke. 🐤

Why did the Ballr pretty printer win employee of the month?

It's the only one on the team whose whole job is making everyone else's code look good. ✨

Why did the Ballr type checker get hired as a nightclub bouncer?

Because nothing gets past it without exactly the right kind of ID. 🪪

Why is `main()` the laziest function in every Ballr game?

It creates the gameboards, registers them, hands everything off to `run_loop()` — and then takes credit for the whole game. 🏆

Why is the Ballr collision detector terrible at parties?

It can't be in the same place as anyone else without making it everyone's problem. 💥

Why did `helloworld.blr` get stage fright?

It's been the opening act for every compiler demo since day one, and it still only knows one line. 🎬
