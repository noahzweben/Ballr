#include "ballr.h"
#include "window.h"

int main() {
    gameboard_t *main_board = malloc(sizeof(gameboard_t));    
    blr_vec_t main_size = {500, 500};
    blr_color_t main_clr = {0, 255, 255};
    gb_init(main_board, "main", main_size, main_clr);
    run_loop(); 
}
