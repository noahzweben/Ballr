#include "ballr.h"
#include "window.h"

void main_init(gameboard_t *board) {

}

gameboard_t *main_create() {
    gameboard_t *main_board = malloc(sizeof(gameboard_t));    
    main_board->name = "main";
    blr_size_t main_board_size = {500, 500};
    main_board->size = main_board_size;
    blr_color_t main_board_color = {0, 255, 255};
    main_board->color = main_board_color;
    main_board->ents = NULL;
    main_board->init_fn = main_init;
    register_gb(main_board);
    return main_board;
}

int main() {
    main_create();   
    run_loop(); 
}
