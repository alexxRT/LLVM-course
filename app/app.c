#include "sim.h"

const int      SPEED    = 1;
const uint32_t COLOR    = 0xFF000000;
const int      CENTER_X = WIN_WIDTH / 2;

typedef struct circle_t {
    int center_y;
    int velocity;
    int radius;
} circle_t;

uint32_t get_pixel_color(int x, int y, circle_t c) {
    int x_squared = (x - CENTER_X) * (x - CENTER_X);
    int y_squared = (y - c.center_y) * (y - c.center_y);
    int r_squared = (c.radius) * (c.radius);

    if (x_squared + y_squared <= r_squared)
            return COLOR;
    return 0xD3D3D3FF;
}

void app() {
    // init circle
    circle_t circle = {};
    circle.center_y = WIN_HIGHT / 2;
    circle.velocity = SPEED;
    circle.radius   = WIN_WIDTH / 10;

    // now we need to paint circle moving
    while(1) {
        for (int y = 0; y < WIN_HIGHT; y ++) {
            for (int x = 0; x < WIN_WIDTH; x ++) {
                uint32_t color = get_pixel_color(x, y, circle);
                paint_pixel(x, y, color);
            }
        }
        // displays colored pixels
        flush_window();
      
        if (WIN_HIGHT - circle.center_y < circle.radius) {
            circle.velocity = -circle.velocity;
            circle.center_y = WIN_HIGHT - circle.radius;
        }
        // bounce when reaching ceilling
        else if (circle.center_y < circle.radius) {
            circle.velocity  = -circle.velocity;
            circle.center_y = circle.radius;
        }
        circle.center_y += circle.velocity;
    }
}