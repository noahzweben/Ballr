#include "window.h"
#include "ballr.h"

extern gameboard_t *current_board;

void ent_add(entity_t *e) {
    entity_t *elist;
    HASH_FIND_STR(current_board->ents, e->name, elist);
    if (elist == NULL) {
        elist = malloc(sizeof(entity_t));
        elist->name = e->name;
        HASH_ADD_STR(current_board->ents, name, elist);
    }
    LL_APPEND(elist, e);
}

void ent_remove(entity_t *e) {
    entity_t *elist;
    HASH_FIND_STR(current_board->ents, e->name, elist);
    if (elist != NULL) {
        LL_DELETE(elist, e);
	free(e);
    }
}

int rect_intersect(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
    if (x1 > x2 + w2 ||
        x2 > x1 + w1 ||
        y1 > y2 + h2 ||
        y2 > y1 + h1) {
        return 1;
    } else {
        return 0;
    }
}

int ents_touching(entity_t *e1, entity_t *e2) {
    return rect_intersect(e1->pos.x, e1->pos.y, e1->size.w, e1->size.h,
        e2->pos.x, e2->pos.y, e2->size.w, e2->size.h);
}

void chk_collision(entity_t *e, const char *other_name, void (*callback)(entity_t *, entity_t *)) {
    entity_t *elist;
    HASH_FIND_STR(current_board->ents, other_name, elist);

    if (elist == NULL) {
        return;
    }

    entity_t *tmp, *elt;
    LL_FOREACH_SAFE(elist, elt, tmp) {
        if (e == elt) {
            continue;
        } else if (ents_touching(e, elt)) {
            callback(e, elt);
        }
    }
}

int chk_keypress(int keycode) {
    return is_key_down(keycode);
}
