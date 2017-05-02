#include <stdio.h>
#include <stdlib.h>
#include "SDL2/SDL.h"
#include "window.h"

#define MS_PER_FRAME 8

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;

SDL_Window *window = NULL;
SDL_Surface *screenSurface = NULL;

const Uint8 *kb_state = NULL;

gameboard_t *boards = NULL;
gameboard_t *current_board = NULL;

entity_t *to_delete = NULL;

int should_restart = 0;

void restart() {
    should_restart = 1;
}

void reset_board() {
    entity_t *elist;
    for (elist = current_board->ents; elist != NULL; elist = elist->hh.next) {
        entity_t *tmp, *elt;
        LL_FOREACH_SAFE(elist->next, elt, tmp) {
            LL_DELETE(elist, elt);    
        }
    } 
}

void register_gb(gameboard_t *board) {
    if (HASH_COUNT(boards) == 0) {
        current_board = board;
        if (board->init_fn != NULL) {
            board->init_fn(board);
        }
    }

    gameboard_t *p;
    HASH_FIND_STR(boards, board->name, p);
    if (p == NULL) {
        HASH_ADD_STR(boards, name, board);
    }
}

int is_key_down(int scancode) {
    return (int)kb_state[scancode];
}

int initWindow()
{

	if ( SDL_Init ( SDL_INIT_VIDEO ) < 0 ){
		printf( "SDL could not initialize! SDL Error: %s\n", SDL_GetError() );
		return 0;
	} else {

		int board_w = (current_board->size).w;
        int board_h = (current_board->size).h;
        window = SDL_CreateWindow( "Hello World", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, board_w, board_h, SDL_WINDOW_SHOWN );
		
        if ( window == NULL ) {
			printf( "Window could not be created. SDL Error: %s\n", SDL_GetError() );
			return 0;
		} else {
			screenSurface = SDL_GetWindowSurface( window );		
			if ( screenSurface == NULL ) {
				printf( "Surface could not be created! SDL Error: %s\n", SDL_GetError() );
				return 0;
			}
		}
	}

	return 1;
}

void closeWindow()
{	
	SDL_DestroyWindow(window);
	window = NULL;
	SDL_Quit();
}

int inEndZone( SDL_Rect block, SDL_Rect endZone )
{

    int leftBlock = block.x;
    int rightBlock = block.x + block.w;
    int bottomBlock = block.y;
    int topBlock = block.y + block.h;
        
    int leftEZ = endZone.x;
    int rightEZ = endZone.x + endZone.w;
    int bottomEZ = endZone.y;
    int topEZ  = endZone.y + endZone.h;

    if ( bottomBlock > bottomEZ && topBlock < topEZ && leftBlock > leftEZ && rightBlock < rightEZ ) {
    	return 1;
    }

    return 0;
}

void draw_entity(entity_t *e) {
    SDL_Rect r;
    r.x = e->pos.x;
    r.y = e->pos.y;
    r.w = e->size.w;
    r.h = e->size.h;

    int red = e->color.r;
    int green = e->color.g;
    int blue = e->color.b;

    SDL_FillRect(screenSurface, &r, SDL_MapRGB(screenSurface->format, red, green, blue));
}

int run_loop()
{
    if ( !initWindow() ){
        printf( "Window initialization failed.");
        return 0;
    } 

    int quit = 0;
    SDL_Event e;
	
    SDL_FillRect( screenSurface, NULL, SDL_MapRGB( screenSurface->format, 0xFF, 0xFF, 0xFF ) );
    SDL_UpdateWindowSurface( window );

    while( !quit ) {
    	while ( SDL_PollEvent ( &e ) != 0 ) {
            SDL_PumpEvents();

            if (e.type == SDL_QUIT) {
                quit = 1;
            }
    	}

        blr_color_t c = current_board->color;
        Uint32 bg_color_sdl = SDL_MapRGB(screenSurface->format, c.r, c.g, c.b);
        SDL_FillRect(screenSurface, NULL, bg_color_sdl);
        kb_state = SDL_GetKeyboardState(NULL);

        entity_t *elist;
        for (elist = current_board->ents; elist != NULL; elist = elist->hh.next) {
            entity_t *tmp, *elt;
            LL_FOREACH_SAFE(elist->next, elt, tmp) {
                if (elt->frame_fn != NULL) {
                    elt->frame_fn(elt);
                }
                draw_entity(elt);
            }
        } 

        if (should_restart) {
             reset_board();
             current_board->init_fn(current_board);
             should_restart = 0;
        }

        entity_t *tmp, *elt;
        LL_FOREACH_SAFE(to_delete, elt, tmp) {
            LL_DELETE(to_delete, elt);
            free(elt->members);
            free(elt);
        } 

        SDL_UpdateWindowSurface( window );
        SDL_Delay(MS_PER_FRAME);
    }

    closeWindow();

	return 0;
}
