#include <SDL2/SDL.h>
#include <assert.h>
#include <stdio.h>


#ifndef SIM_H
#define SIM_H
void create_window();
void paint_pixel(int x, int y, uint32_t rgba);
void flush_window();
void quit_window();
#endif

typedef struct circle_t circle_t;

extern uint32_t get_pixel_color(int x, int y, circle_t* circles);
extern void     update_circles(circle_t* circles);
extern void     app();