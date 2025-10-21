# Ballr

A simple 2D game language

## Building

To build a Ballr game, from the root directory type `make <filename>.game`.

This will:
1. Build the compiler if it has changed
2. Look for a file called `<filename>.blr`
3. Use the `ballr` executable to compile this to LLVM
4. Build the LLVM file and link it with the runtime located at `runtime/build`

## SSH

If ssh-ing into a virtual machine, make sure to use `-X` to enable X-forwarding. This will allow the screen to be displayed.

## Codegen

Codegen is broken down into the following steps:

### Entities

To generate the code for entities, each needs a create function and a frame function.

- **Create function**: Takes a pointer to the entity as an argument and is responsible for setting the entity's given values for size, color, etc.
- **Frame function**: What the events compile to. Every frame, the runtime will call each entity's frame function, which checks for event conditions and executes the code if needed.

### Gameboards

Each gameboard has a create function and an init function.

- **Create function**: Behaves the same as the entity's create function
- **Init function**: Corresponds directly to the code after the `init =>` block in the `gameboard` definition

### Main

When generating the main method, we:
1. Create each gameboard using that board's create function
2. Use `register_gb` to let the runtime build a list of boards keyed by name, so that later (for functions like `load()`) we can refer to boards by their name
3. Call `run_loop()` to start the execution of the game
