#define ANIM_FRAME_DURATION 75 // how long each frame lasts in ms
#define IDLE_FRAME_DURATION 200
#define ANIM_SIZE 512 // number of bytes in array, minimize for adequate firmware size, max is 1024
#define IDLE_FRAMES 5
#define IDLE_TIMEOUT 2000 // the amount of time it takes to return to idle
#define TAP_FRAMES 2
#define KEYS_SIZE 70 // the number of keys stored in the array that tracks keypresses; how many keys are on the board?

//#include "animation.h"
#include "frames.h"

enum anim_states
{
    Idle,
    Prep,
    Tap
};
uint8_t anim_state = Idle;
uint32_t idle_timeout_timer = 0;
uint32_t bongo_timeout_timer = 0;
uint32_t anim_timer = 0;
uint8_t current_idle_frame = 0;
uint8_t current_tap_frame = 0;

bool pressed_keys[KEYS_SIZE];
bool pressed_keys_prev[KEYS_SIZE];

bool key_down = 0;


bool detect_key_down(void) {
    //store the previous cycles cache
    for (uint8_t i = 0; i < KEYS_SIZE; ++i) {
        pressed_keys_prev[i] = pressed_keys[i];
    }

    // fill cache with currently pressed keys
    for (uint8_t x = 0; x < MATRIX_ROWS; x++) {
        for (uint8_t y = 0; y < MATRIX_COLS; y++) {
            // is this key is currently down?
            if (((matrix_get_row(x) & (1 << y)) > 0)) {
                pressed_keys[x * MATRIX_COLS + y] = 1;
            }
            else {
                pressed_keys[x * MATRIX_COLS + y] = 0;
            }
        }
    }

    // check for a new key down compared to last cycle
    for (uint8_t i = 0; i < KEYS_SIZE; ++i)
    {
        if (pressed_keys[i] && !pressed_keys_prev[i])
        {
            return true;
        }
    }
    return false;
}

void eval_anim_state(void)
{
    key_down = detect_key_down();

    switch (anim_state)
    {
        case Idle:
            if (key_down) // Idle to Tap
            {
                anim_state = Tap;
                bongo_timeout_timer = timer_read32();
            }
            break;

        case Prep:
            if (key_down) // Prep to Tap
            {
                anim_state = Tap;
                bongo_timeout_timer = timer_read32();
            }
            else if (timer_elapsed32(idle_timeout_timer) >= IDLE_TIMEOUT) // Prep to Idle
            {
                anim_state = Idle;
                current_idle_frame = 0;
            }
            break;

        case Tap:
            if (!key_down && timer_elapsed32(bongo_timeout_timer) >= ANIM_FRAME_DURATION ) // Tap to Prep
            {
                anim_state = Prep;
                idle_timeout_timer = timer_read32();
                current_tap_frame = (current_tap_frame + 1) % TAP_FRAMES;
            }
            break;

        default:
            break;
    }
}

static void oled_render_bongo(void)
{
    eval_anim_state();

    oled_set_cursor(0, 0);

    switch (anim_state)
    {
        case Idle:
            oled_write_raw_P(idle[current_idle_frame], ANIM_SIZE);
            if (timer_elapsed32(anim_timer) > IDLE_FRAME_DURATION)
            {
                current_idle_frame = (current_idle_frame + 1) % IDLE_FRAMES;
                anim_timer = timer_read32();
            }
            break;

        case Prep:
            oled_write_raw_P(prep[0], ANIM_SIZE);
            break;

        case Tap:
            oled_write_raw_P(tap[current_tap_frame], ANIM_SIZE);
            break;

        default:
            break;
    }
}