// document and rename layers and adjust rules for tap timing and mouse acceleration
oled_rotation_t oled_init_user(oled_rotation_t rotation) {
    return rotation;
}

void oled_render_default_layer(void) {
    oled_set_cursor(0, 0);

    switch (base_layer) {
        case ((long)1 << D_QWERTY):
            oled_write_ln_P(PSTR("QWERTY"), false);
            break;
        case ((long)1 << D_Q_LEFT):
            oled_write_ln_P(PSTR("QWERTY_LEFT"), false);
            break;
        case ((long)1 << D_GAME):
            oled_write_ln_P(PSTR("GAME"), false);
            break;
        default:
            oled_write_ln_P(PSTR("QWERTY"), false);
            break;
    }
}

void oled_render_padding(void) {
    oled_write_P(PSTR(" "), false);
}

void oled_render_inverted_padding(void) {
    oled_write_P(PSTR(" "), true);
}

void oled_render_triggered_layer(void) {
    oled_set_cursor(0, 2);
    oled_write_P(PSTR(" -> TRIG "), false);

    oled_render_inverted_padding();
    switch (layer_state) {
        case ((long)1 << T_FUNC):
            oled_write_P(PSTR("func"), true);
            break;
        case ((long)1 << T_NUMPAD):
            oled_write_P(PSTR("numpad"), true);
            break;
        default:
            oled_write_P(PSTR("null"), true);
            break;
    }
    oled_render_inverted_padding();

    oled_write_ln_P(PSTR(""), false);
}

void oled_render_momentary_layer(void) {
    oled_set_cursor(0, 3);
    oled_write_P(PSTR(" -> HOLD "), false);

    oled_render_inverted_padding();
    switch (layer_state) {
        case ((long)1 << M_RAISE):
            oled_write_P(PSTR("raise"), true);
            break;
        case ((long)1 << M_NAV):
            oled_write_P(PSTR("nav"), true);
            break;
        case ((long)1 << D_QWERTY):
        case ((long)1 << D_Q_LEFT):
        case (((long)1 << M_RAISE) | ((long)1 << M_WINDOW)):
        case (((long)1 << M_NAV) | ((long)1 << M_WINDOW)):
        case ((long)1 << M_WINDOW):
            if ((get_mods() & (MOD_BIT(KC_LGUI) | MOD_BIT(KC_LCTL) | MOD_BIT(KC_LSFT))) == (MOD_BIT(KC_LGUI) | MOD_BIT(KC_LCTL) | MOD_BIT(KC_LSFT))) {
                oled_write_P(PSTR("wm-move"), true);
            }
            else if ((get_mods() & (MOD_BIT(KC_LGUI) | MOD_BIT(KC_LCTL))) == (MOD_BIT(KC_LGUI) | MOD_BIT(KC_LCTL))) {
                oled_write_P(PSTR("wm-focus"), true);
            }
            break;

        // case (2 ^ M_RAISE_LEAGUE):
        //     break;
        case ((long)1 << M_RAISE_LEAGUE):
            break;



        default:
            oled_write_P(PSTR("null"), true);
            break;
    }
    oled_render_inverted_padding();

    oled_write_ln_P(PSTR(""), false);
}

bool oled_task_user(void) {
    oled_render_default_layer();
    oled_render_triggered_layer();
    oled_render_momentary_layer();
    return false;
}