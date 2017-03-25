#ifndef WINDOW_H
#define WINDOW_H

#include "ballr.h"

void register_gb(gameboard_t *board);

int run_loop();

int is_key_down(int scancode);

#endif
