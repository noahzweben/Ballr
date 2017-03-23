#include <stdio.h>
#include <stdlib.h>
#include "SDL2/SDL.h"

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;

SDL_Window *window = NULL;
SDL_Surface *screenSurface = NULL;

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
			//renderer = SDL_CreateRenderer( window, -1, SDL_RENDERER_ACCELERATED );		
			
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

int main( int argc, char ** argv )
{
	
	if ( !initWindow() ){
		printf( "Window initialization failed.");
		return 0;
	} 

	int quit = 0;
	SDL_Event e;
	SDL_Rect block = {10,SCREEN_HEIGHT / 2 - 10, 20, 20 };
	SDL_Rect endZone = {SCREEN_WIDTH - 100, SCREEN_HEIGHT / 2 - 100, 100, 200 };
	
	SDL_FillRect( screenSurface, NULL, SDL_MapRGB( screenSurface->format, 0xFF, 0xFF, 0xFF ) );
	SDL_UpdateWindowSurface( window );

	while( !quit ) {

		while ( SDL_PollEvent( &e ) != 0 ) {

			SDL_FillRect( screenSurface, NULL, SDL_MapRGB( screenSurface->format, 0xFF, 0xFF, 0xFF ) );
			SDL_FillRect( screenSurface, &endZone, SDL_MapRGB( screenSurface->format, 0x00, 0xFF, 0x00 ));
			SDL_FillRect( screenSurface, &block, SDL_MapRGB( screenSurface->format, 0xFF, 0x00, 0x00 ));
			SDL_UpdateWindowSurface( window );

			if ( inEndZone( block, endZone ) ) {
				block.x = 10;
				block.y = SCREEN_HEIGHT / 2 - 10;
				continue;
			}

            if ( e.type == SDL_QUIT ) {

                quit = 1;

            } else if ( e.type == SDL_KEYDOWN ){
            	
            	switch( e.key.keysym.sym )
                {
                    case SDLK_UP:
                    block.y -= 10;
                    break;

                    case SDLK_DOWN:
                    block.y += 10;
                    break;

                    case SDLK_LEFT:
                    block.x -= 10;
                    break;

                    case SDLK_RIGHT:
                    block.x += 10;
                    break;

                    default:
                
                    break;
                }
            }
        }		
	}
		
	closeWindow();

	return 0;
}
