#include <stdio.h>
#include <stdlib.h>
// #include "SDL2/SDL.h"
#include "/Users/Jessie/Desktop/SDL_PLT/SDL/include/SDL.h"
#include "window.h"

#define MS_PER_FRAME 17

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;

SDL_Window *window = NULL;
SDL_Surface *screenSurface = NULL;

const Uint8 *kb_state = NULL;

gameboard_t *boards = NULL;
gameboard_t *current_board = NULL;

void register_gb(gameboard_t *board) {
    current_board = board;
}

int initWindow()
{

	if ( SDL_Init ( SDL_INIT_VIDEO ) < 0 ){

		printf( "SDL could not initialize! SDL Error: %s\n", SDL_GetError() );
		return 0;

	} else {

		window = SDL_CreateWindow( "Hello World", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN );
		
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

int run_loop()
{
	if ( !initWindow() ){
		printf( "Window initialization failed.");
		return 0;
	} 

	int quit = 0;
	
	SDL_FillRect( screenSurface, NULL, SDL_MapRGB( screenSurface->format, 0xFF, 0xFF, 0xFF ) );
	SDL_UpdateWindowSurface( window );

	while( !quit ) {

        SDL_PumpEvents();
        blr_color_t c = current_board->color;
        Uint32 bg_color_sdl = SDL_MapRGB(screenSurface->format, c.r, c.g, c.b);
        SDL_FillRect(screenSurface, NULL, bg_color_sdl);

        SDL_UpdateWindowSurface( window );
        SDL_Delay(MS_PER_FRAME);
    }
		
	closeWindow();

	return 0;
}
