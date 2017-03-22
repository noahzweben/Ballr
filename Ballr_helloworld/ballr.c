#include "window.h"
#include "ballr.h"

extern gameboard_t *current_board;

void gb_init(gameboard_t *board, const char *name,  blr_vec_t size, blr_color_t color) {
    board->name = name;
    board->size = size;
    board->color = color;
    register_gb(board);
}