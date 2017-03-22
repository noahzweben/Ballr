#ifndef BALLR_H
#define BALLR_H

typedef struct blr_color {
    int r;
    int g;
    int b;
} blr_color_t;

typedef struct blr_vec {
    int x;
    int y;
} blr_vec_t;

typedef struct entity {
    const char *name;
    blr_vec_t size;
    blr_vec_t pos;
    blr_color_t color;
} entity_t;

typedef struct gameboard {
    const char *name;
    blr_vec_t size;
    blr_color_t color;
} gameboard_t;

void gb_init(gameboard_t *board, const char *name, blr_vec_t size, blr_color_t color);

#endif
