#include <SDL.h>
#include <assert.h>
#include <math.h>


#ifndef SIM_H
#define SIM_H
void create_window();
extern "C" void paint_pixel(int x, int y, uint32_t rgba);
extern "C" void flush_window();
void quit_window();
#define WIN_WIDTH 500
#define WIN_HIGHT 250
#endif

typedef struct square_t square_t;

extern uint32_t get_pixel_color(int x, int y, square_t circles);
extern "C" void     app();