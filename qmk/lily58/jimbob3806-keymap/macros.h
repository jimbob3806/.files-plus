enum layer_macros {
    DF_D_QWERTY = SAFE_RANGE,
    DF_D_Q_LEFT,
    DF_D_GAME
};

uint8_t base_layer;
bool process_record_user(uint16_t keycode, keyrecord_t* record) {
    switch (keycode) {
        case DF_D_QWERTY:
            if (record->event.pressed) {
                base_layer = 1 << D_QWERTY;
                default_layer_set(1 << D_QWERTY);
            }
            return false;
        case DF_D_Q_LEFT:
            if (record->event.pressed) {
                base_layer = 1 << D_Q_LEFT;
                default_layer_set(1 << D_Q_LEFT);
            }
            return false;
        case DF_D_GAME:
            if (record->event.pressed) {
                base_layer = 1 << D_GAME;
                default_layer_set(1 << D_GAME);
            }
            return false;
        default:
            return true;
    }
}