#include "sim.h"

#define FRAME_TICKS 20
static uint32_t Tick = 0;

SDL_Renderer* renderer = NULL;
SDL_Window*   window   = NULL;

void create_window() {
    SDL_Init(SDL_INIT_VIDEO);

    SDL_DisplayMode d_mode = {};
    SDL_GetCurrentDisplayMode(0, &d_mode);

    SDL_CreateWindowAndRenderer(WIN_WIDTH, WIN_HIGHT, 0, &window, &renderer);
    SDL_SetWindowTitle(window, "LLVM Graphic App");
    SDL_SetRenderDrawColor(renderer, 0xFF, 0xFF, 0xFF, 0);
    SDL_RenderClear(renderer);

    flush_window();
}

void paint_pixel(int x, int y, uint32_t rgba) {
    assert(x <= WIN_WIDTH && "x coordinate is out of range to paint pixel");
    assert(y <= WIN_HIGHT && "y coordinate is out of range to paint pixel");

    uint8_t alpha = rgba & 0xFF;
    uint8_t red   = (rgba >> 24) & 0xFF;
    uint8_t green = (rgba >> 16) & 0xFF;
    uint8_t blue  = (rgba >>  8) & 0xFF;

    SDL_SetRenderDrawColor(renderer, red, green, blue, alpha);
    SDL_RenderDrawPoint(renderer, x, y);

    Tick = SDL_GetTicks();
}


void flush_window() {
    SDL_PumpEvents();
    assert(SDL_TRUE != SDL_HasEvent(SDL_QUIT) && "User-requested quit");
    // Uint32 cur_ticks = SDL_GetTicks() - Ticks;
    // if (cur_ticks < FRAME_TICKS) {
    //     SDL_Delay(FRAME_TICKS - cur_ticks);
    // }
    SDL_RenderPresent(renderer);
}

void quit_window() {
    SDL_Event event;
    while (1) {
        if (SDL_PollEvent(&event) && event.type == SDL_QUIT) break;
    }
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
}