#include <animation.h>

// document and rename layers and adjust rules for tap timing and mouse acceleration
oled_rotation_t oled_init_user(oled_rotation_t rotation) {
  return OLED_ROTATION_180;  // flips the display 180 degrees if offhand
}

void oled_render_mod_states(void) {
    uint8_t mod_state;
    mod_state = get_mods();

    if (mod_state & MOD_MASK_SHIFT) {
        oled_set_cursor(0, 0);
        oled_write_P(PSTR("SFT"), false);
    }

    if (mod_state & MOD_MASK_GUI) {
        oled_set_cursor(0, 2);
        oled_write_P(PSTR("GUI"), false);
    }

    if (mod_state & MOD_MASK_CTRL) {
        oled_set_cursor(4, 0);
        oled_write_P(PSTR("CTL"), false);

    }

    if (mod_state & MOD_MASK_ALT) {
        oled_set_cursor(4, 2);
        oled_write_P(PSTR("ALT"), false);
    }
}

bool oled_task_user(void) {
    oled_render_bongo();
    oled_render_mod_states();
    return false;
}