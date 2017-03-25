#ifndef BALLR_H
#define BALLR_H

#include "uthash/include/uthash.h"
#include "uthash/include/utlist.h"

typedef struct blr_color {
    int r;
    int g;
    int b;
} blr_color_t;

typedef struct blr_pos {
    int x;
    int y;
} blr_pos_t;

typedef struct blr_size {
    int w;
    int h;
} blr_size_t;


typedef struct entity {
    const char *name;
    blr_size_t size;
    blr_pos_t pos;
    blr_color_t color;
    void (*frame_fn)(struct entity *);
    struct entity *next;
    UT_hash_handle hh;
} entity_t;

typedef struct gameboard {
    const char *name;
    blr_size_t size;
    blr_color_t color;
    entity_t *ents;
    void (*init_fn)(struct gameboard *);
    UT_hash_handle hh;
} gameboard_t;

void ent_add(entity_t *e);

void ent_remove(entity_t *e);

void chk_collision(entity_t *e, const char *other_name, void (*callback)(entity_t *, entity_t*));

int chk_keypress(int keycode);

#endif
