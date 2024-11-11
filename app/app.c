#include "sim.h"

const int      SPEED    = 1;
const uint32_t COLOR    = 0xFF000000;
const int      CENTER_X = WIN_WIDTH / 2;

typedef struct square_t {
    int center_y;
    int side_length;
} square_t;

uint32_t get_pixel_color(int x, int y, square_t c) {
    if (abs((x - CENTER_X) + (y - c.center_y)) + abs((x - CENTER_X) - (y - c.center_y)) <= c.side_length)
        return COLOR;

    return 0xD3D3D3FF;
}

void app() {
    // init square
    square_t square    = {};
    square.center_y    = WIN_HIGHT / 2;
    square.side_length = WIN_WIDTH / 10;

    // now we need to paint square moving
    while(1) {
        for (int y = 0; y < WIN_HIGHT; y ++) {
            for (int x = 0; x < WIN_WIDTH; x ++) {
                uint32_t color = get_pixel_color(x, y, square);
                paint_pixel(x, y, color);
            }
        }
        // displays colored pixels
        flush_window();
      
        if (square.center_y >= WIN_HIGHT + square.side_length / 2) {
            square.center_y = -square.side_length;
        }
        square.center_y += SPEED;
    }
}