#include <stdio.h>
#include <stdlib.h>
#include "/Users/Jessie/Desktop/SDL_PLT/SDL/include/SDL.h"
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

int main( int argc, char ** argv )
{
	
	if ( !initWindow() ){
		printf( "Window initialization failed.");
		return 0;
	} 

	int quit = 0;
	SDL_Event e;
	SDL_Rect block = { 50, 50, SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4 };


	while( !quit ) {

		while ( SDL_PollEvent( &e ) != 0 ) {
            
            SDL_FillRect( screenSurface, NULL, SDL_MapRGB( screenSurface->format, 0xFF, 0xFF, 0xFF ) );
			SDL_UpdateWindowSurface( window );

			SDL_FillRect( screenSurface, &block, SDL_MapRGB( screenSurface->format, 0x00, 0x00, 0xFF ));
			SDL_UpdateWindowSurface( window );

            if ( e.type == SDL_QUIT ) {

                quit = 1;

            } else if (e.type == SDL_KEYDOWN ){
            	
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

       	SDL_FillRect( screenSurface, NULL, SDL_MapRGB( screenSurface->format, 0xFF, 0xFF, 0xFF ) );
		SDL_FillRect( screenSurface, &block, SDL_MapRGB( screenSurface->format, 0x00, 0x00, 0xFF ));
		SDL_UpdateWindowSurface( window ); 
		
	}
		
	closeWindow();

	return 0;
}
