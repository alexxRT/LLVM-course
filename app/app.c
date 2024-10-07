#include "sim.h"

#define NUM_CIRCLES 8
const int SPEED = 1;

typedef struct circle_t {
    int center_x;
    int center_y;
    // expressed in pixels per frame
    int velocity;
    int radius;
    //sets circle color
    uint32_t rgba;
} circle_t;

uint32_t get_pixel_color(int x, int y, circle_t* circles) {
    assert(x <= WIN_WIDTH && "x coordinate is out of range to paint pixel");
    assert(y <= WIN_HIGHT && "y coordinate is out of range to paint pixel");

    for (int i = 0; i < NUM_CIRCLES; i ++) {
        int x_squared = (x - circles[i].center_x) * (x - circles[i].center_x);
        int y_squared = (y - circles[i].center_y) * (y - circles[i].center_y);
        int r_squared = (circles[i].radius) * (circles[i].radius);
        if (x_squared + y_squared <= r_squared)
            return circles[i].rgba;
    }
    return 0xD3D3D3FF;
}

void update_circles(circle_t* circles) {
    for (size_t i = 0; i < NUM_CIRCLES; i ++) {
        // bounce when reaching floor
        if (WIN_HIGHT - circles[i].center_y < circles[i].radius) {
            circles[i].velocity = -circles[i].velocity;
            circles[i].center_y   = WIN_HIGHT - circles[i].radius;
        }
        // bounce when reaching ceilling
        else if (circles[i].center_y < circles[i].radius) {
            circles[i].velocity = -circles[i].velocity;
            circles[i].center_y   = circles[i].radius;
        }

        circles[i].center_y += circles[i].velocity;
    }
}

void app() {
    circle_t circles[NUM_CIRCLES];
    uint32_t max_radius = WIN_WIDTH / (2 * NUM_CIRCLES);

    uint32_t color = 0xFF000000;
    uint32_t step  = 3;

    // init circles and colors
    for (uint32_t i = 0; i < NUM_CIRCLES; i++) {
        circles[i].radius = max_radius - i * max_radius / NUM_CIRCLES;
        circles[i].center_x = 2 * i * max_radius + circles[i].radius;
        circles[i].center_y = WIN_HIGHT / 2;
        // init circles speeds
        circles[i].velocity = SPEED * (1 + i);
        // 8 bits for alpha value
        circles[i].rgba = (color >> (step * i));
    }

    // now we need to paint circle
    // lets take circles[0] for begin
    while(1) {
        for (int y = 0; y < WIN_HIGHT; y ++) {
            for (int x = 0; x < WIN_WIDTH; x ++) {
                uint32_t color = get_pixel_color(x, y, circles);
                paint_pixel(x, y, color);
            }
        }
        // displays colored pixels
        flush_window();
      
        // updates circles positions and velocities
        update_circles(circles);
    }
}
