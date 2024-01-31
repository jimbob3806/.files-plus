/*
Copyright 2019 @foostan
Copyright 2020 Drashna Jaelre <@drashna>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include QMK_KEYBOARD_H
#include <stdio.h>

#define D_QWERTY            0
#define D_Q_LEFT            1
#define D_GAME              2

#define T_FUNC              3
#define T_NUMPAD            4

#define M_RAISE             5
#define M_NAV               6
#define M_WINDOW            7

#define T_LEAGUE            8
#define T_FPS               9
// #define T_GAME_NAME         10
// #define T_GAME_NAME         11

#define M_RAISE_SPLIT       12
#define M_LOWER_SPLIT       13

#define M_RAISE_GAME        14
#define M_LOWER_GAME        15

#define M_RAISE_LEAGUE      16
#define M_LOWER_LEAGUE      17

#define M_RAISE_FPS         18
#define M_LOWER_FPS         19

// #define M_RAISE_GAME_NAME   20
// #define M_LOWER_GAME_NAME   21

// #define M_RAISE_GAME_NAME   22
// #define M_LOWER_GAME_NAME   23

#define _TR             31

#include <macros.h>
#ifdef OLED_ENABLE
#include <oled.h>
#endif

// change nav layer to lower layer name as normal in other keymaps
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    /*
     * D_QWERTY
     *
     *  -----------------------------------------------                           -----------------------------------------------
     * | Esc   |   1   |   2   |   3   |   4   |   5   |                         |   6   |   7   |   8   |   9   |   0   |   `   |
     * |-----------------------------------------------|                         |-----------------------------------------------|
     * | L_ALT |   Q   |   W   |   E   |   R   |   T   |                         |   Y   |   U   |   I   |   O   |   P   | R_ALT |
     * |-----------------------------------------------|-------           -------|-----------------------------------------------|
     * | L_SFT |   A   |   S   |   D   |   F   |   G   | [     |         | ]     |   B   |   H   |   J   |   K   |   L   | R_SFT |
     * |-----------------------------------------------|       |         |       |-----------------------------------------------|
     * | L_CTL |   Z   |   X   |   C   |   V   |   -   |-------|         |-------|   =   |   N   |   M   |   ,   |   .   | R_CTL |
     *  -----------------------------------------------       |           \       -----------------------------------------------
     *               | LGUI    | LGUI    | L_1     | Space   |             \ Enter   \ L_2     \ R_ALT   \ R_ALT   \
     *              |         |         |         |         |               \         \         \         \         \
     *              ----------------------------------------                 ----------------------------------------
     *
     * Mod-Tap Keys:
     *      L_ALT --> app context menu
     *      L_SFT --> caps lock
     *      L_CTL --> \ and |
     *      R_ALT --> ' and "
     *      R_SFT --> ; and :
     *      R_CTL --> / and ?
     *
     * Momentary Layer Keys:
     *              TAP         HOLD
     *      L_1 --> tab         M_NAV
     *      L_2 --> backspace   M_RAISE
     */ 
    [D_QWERTY] = LAYOUT(
    // 6x4x2 (width, height, splits) +2 ortholinear key group
KC_ESC,            KC_1,      KC_2,      KC_3,      KC_4,      KC_5,                              KC_6,      KC_7,      KC_8,      KC_9,      KC_0,      KC_GRV,
LALT_T(KC_APP),    KC_Q,      KC_W,      KC_E,      KC_R,      KC_T,                              KC_Y,      KC_U,      KC_I,      KC_O,      KC_P,      RALT_T(KC_QUOT),
LSFT_T(KC_CAPS),   KC_A,      KC_S,      KC_D,      KC_F,      KC_G,                              KC_B,      KC_H,      KC_J,      KC_K,      KC_L,      RSFT_T(KC_SCLN),
LCTL_T(KC_BSLS),   KC_Z,      KC_X,      KC_C,      KC_V,      KC_MINS,   KC_LBRC,     KC_RBRC,   KC_EQL,    KC_N,      KC_M,      KC_COMM,   KC_DOT,    RCTL_T(KC_SLSH),
    // 4x1x2 (width, height, splits) separated thumb key group
            LM(M_WINDOW, MOD_LGUI | MOD_LCTL), KC_LGUI, LT(M_NAV, KC_TAB), KC_SPC,     KC_ENT, LT(M_RAISE, KC_BSPC), RGUI_T(KC_DEL), LM(M_WINDOW, MOD_LGUI | MOD_LCTL | MOD_LSFT)
    ),

    /*
     * D_GAME
     *
     *  -----------------------------------------------                            -----------------------------------------------
     * | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX |                          |   Y   |   U   |   I   |   O   |   P   | Bspc  |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX |                          |   =   |   H   |   J   |   K   |   L   | R_SFT |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX |-------            -------|   |   |   G   |   B   |   N   |   M   | R_CTL |
     *  -----------------------------------------------       |           \        -----------------------------------------------
     *                         |  XXXXX  |  XXXXX  |  XXXXX  |             \ Enter   \ L_2     \ R_ALT   \
     *                        |         |         |         |               \         \         \         \
     *                        ------------------------------                 ------------------------------
     *
     * Mod-Tap Keys:
     *      L_SFT --> Caps Lock
     *      L_CTL --> [ and {
     *      R_SFT --> ; and :
     *      R_CTL --> / and ?
     *      R_ALT --> .
     *
     * Momentary Layer Keys:
     *              TAP     HOLD
     *      L_1 --> Tab     M_NAV
     *      L_2 --> ,       M_RAISE
     */
    // [D_GAME] = LAYOUT_split_3x6_3(
    // // 6x3x2 (width, height, splits) ortholinear key group
    // //  #######,   #######,   #######,   #######,   #######,   #######,   SPLIT   #######,   #######,   #######,   #######,   #######,   #######,
    //     XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,           KC_Y,      KC_U,      KC_I,      KC_O,      KC_P,      KC_BSPC,
    //     XXXXXXX,   TG(_TR),   TG(_TR),   TG(_TR),   TG(_TR),   XXXXXXX,           KC_EQL,    KC_H,      KC_J,      KC_K,      KC_L,      RSFT_T(KC_SCLN),
    //     XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,           KC_PIPE,   KC_G,      KC_B,      KC_N,      KC_M,      RCTL_T(KC_SLSH),
    // // 3x1x2 (width, height, splits) separated key group
    //                                          XXXXXXX, XXXXXXX, XXXXXXX,           KC_ENT, LT(M_RAISE, KC_COMM), RALT_T(KC_DOT)
    // ),

    /*
     * T_LEAGUE
     *
     *  -----------------------------------------------                            -----------------------------------------------
     * | Esc   |   Q   |   W   |   E   |   R   |   T   |                          |   Y   |   U   |   I   |   O   |   P   | Bspc  |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * | L_SFT |   A   |   S   |   D   |   F   |   -   |                          |   =   |   H   |   J   |   K   |   L   | R_SFT |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * | L_CTL |   Z   |   X   |   C   |   V   |   &   |-------            -------|   [   |   G   |   B   |   N   |   M   | R_CTL |
     *  -----------------------------------------------       |           \        -----------------------------------------------
     *                         | LGUI    | L_1     | Space   |             \ Enter   \ L_2     \ R_ALT   \
     *                        |         |         |         |               \         \         \         \
     *                        ------------------------------                 ------------------------------
     *
     * Mod-Tap Keys:
     *      L_SFT --> Caps Lock
     *      L_CTL --> ` and ~
     *      R_SFT --> ; and :
     *      R_CTL --> / and ?
     *      R_ALT --> .
     *
     * Momentary Layer Keys:
     *              TAP     HOLD
     *      L_1 --> Tab     M_NAV
     *      L_2 --> ,       M_RAISE
     */
//     [T_LEAGUE] = LAYOUT_split_3x6_3(
//     // 6x3x2 (width, height, splits) ortholinear key group
//     //  #######,   #######,   #######,   #######,   #######,   #######,   SPLIT   #######,   #######,   #######,   #######,   #######,   #######,
//         KC_ESC,    KC_Q,      KC_W,      KC_E,      KC_R,      KC_T,              KC_Y,      KC_U,      KC_I,      KC_O,      KC_P,      KC_BSPC,
// LSFT_T(KC_CAPS),   KC_A,      KC_S,      KC_D,      KC_F,      KC_MINS,           KC_EQL,    KC_H,      KC_J,      KC_K,      KC_L,      RSFT_T(KC_SCLN),
//  LCTL_T(KC_GRV),   KC_Z,      KC_X,      KC_C,      KC_V,      KC_AMPR,           KC_LBRC,   KC_G,      KC_B,      KC_N,      KC_M,      RCTL_T(KC_SLSH),
//     // 3x1x2 (width, height, splits) separated key group
//                                     KC_LGUI, LT(M_NAV, KC_TAB), KC_SPC,           KC_ENT, LT(M_RAISE, KC_COMM), RALT_T(KC_DOT)
//     ),

    /*
     * M_RAISE - use thumb keys on left hand to change default layers and swap macro record and paren lines around
     *
     *  -----------------------------------------------                           -----------------------------------------------
     * |       |       |       |       |       |       |                         |       |       |       |       |       |  Esc  |
     * |-----------------------------------------------|                         |-----------------------------------------------|
     * |       |   !   |   @   |   #   |   $   |   %   |                         |   ^   |   &   |   *   |   (   |   )   |       |
     * |-----------------------------------------------|-------           -------|-----------------------------------------------|
     * |       | M1_R  | M1_P  | M2_R  | M2_P  | M_STP | caps- |         | PSCR  | Mute  | Left  | Down  | Up    | Right |       |
     * |-----------------------------------------------| word  |         |       |-----------------------------------------------|
     * |       |   [   |   ]   |   {   |   }   | XXXXX |-------|         |-------| Pause | End   | Pg_Dn | Pg_Up | Home  |       |
     *  -----------------------------------------------       |           \       -----------------------------------------------
     *               | XXXXXXX | XXXXXXX | XXXXXXX | XXXXXXX |             \ XXXXXXX \         \ XXXXXXX \ XXXXXXX \
     *              |         |         |         |         |               \         \         \         \         \
     *              ----------------------------------------                 ----------------------------------------
     *
     */ 
    [M_RAISE] = LAYOUT(
    // 6x4x2 (width, height, splits) +2 ortholinear key group
_______,   _______,   _______,   _______,         _______,         _______,                           _______,   _______,   _______,   _______,   _______,   KC_ESC,
_______,   KC_EXLM,   KC_AT,     KC_HASH,         KC_DLR,          KC_PERC,                           KC_CIRC,   KC_AMPR,   KC_ASTR,   KC_LPRN,   KC_RPRN,   _______,
_______,   DM_REC1,   DM_PLY1,   DM_REC2,         DM_PLY2,         DM_RSTP,                           KC_MUTE,   KC_LEFT,   KC_DOWN,   KC_UP,     KC_RGHT,   _______,
_______,   KC_LBRC,   KC_RBRC,   LSFT(KC_LBRC),   LSFT(KC_RBRC),   XXXXXXX,   CW_TOGG,     KC_PSCR,   KC_PAUS,   KC_END,    KC_PGDN,   KC_PGUP,   KC_HOME,   _______,
    // 4x1x2 (width, height, splits) separated thumb key group
                                                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, _______, XXXXXXX, XXXXXXX
    ),

    /*
     * M_NAV
     *
     *  -----------------------------------------------                            -----------------------------------------------
     * |  L_1  | End   | Pg_Dn | Pg_Up | Home  | M_A1  |                          |  L_4  | M_B3  | M_WD  | M_WU  | M_B4  |  L_7  |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * |  L_2  | Left  | Down  | Up    | Right | M_A2  |                          |  L_5  | M_ML  | M_MD  | M_MU  | M_MR  |  L_8  |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * |  L_3  | Mute  | Pause | P_SCR | M_APP | M_A3  |-------            -------|  L_6  | Left  | Down  | Up    | Right |  L_9  |
     *  -----------------------------------------------       |           \        -----------------------------------------------
     *                         |  XXXXX  |         |  XXXXX  |             \ L_10    \ M_B1    \ M_B2    \
     *                        |         |         |         |               \         \         \         \
     *                        ------------------------------                 ------------------------------
     *
     * Mod-Tap Keys:
     *      L_SFT --> Caps Lock
     *      L_CTL --> [ and {
     *      R_SFT --> ; and :
     *      R_CTL --> / and ?
     *      R_ALT --> .
     *
     * Momentary Layer Keys:
     *              TAP     HOLD
     *      L_10 --> Tab     M_NAV
     *      L_2 --> ,       M_RAISE
     * 
     * Toggle Layer Keys:
     */
    // [M_NAV] = LAYOUT_split_3x6_3(
    // // 6x3x2 (width, height, splits) ortholinear key group
    // //  #######,   #######,   #######,   #######,   #######,   #######,   SPLIT   #######,   #######,   #######,   #######,   #######,   #######,
    // DF_D_QWERTY,   KC_END,    KC_PGDN,   KC_PGUP,   KC_HOME,   KC_ACL0,           TG(_TR),   KC_BTN3,   KC_WH_D,   KC_WH_U,   KC_BTN4,   TG(_TR),
    //   DF_D_GAME,   KC_LEFT,   KC_DOWN,   KC_UP,     KC_RGHT,   KC_ACL1,           TG(_TR),   KC_MS_L,   KC_MS_D,   KC_MS_U,   KC_MS_R,   TG(T_FUNC),
    // DF_D_Q_LEFT,   KC_MUTE,   KC_PAUS,   KC_PSCR,   KC_APP,    KC_ACL2,           TG(_TR),   KC_LEFT,   KC_DOWN,   KC_UP,     KC_RGHT,   TG(T_NUMPAD),
    // // 3x1x2 (width, height, splits) separated key group
    //                                          XXXXXXX, _______, XXXXXXX,           LM(M_WINDOW, MOD_LGUI | MOD_LCTL), KC_BTN1, KC_BTN2
    // ),

    /*
     * T_FUNC
     *  
     *  -----------------------------------------------                            -----------------------------------------------
     * |       |  F1   |  F2   |  F3   |  F4   | XXXXX |                          | XXXXX |  F13  |  F14  |  F15  |  F16  |       |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * |       |  F5   |  F6   |  F7   |  F8   | XXXXX |                          | XXXXX |  F17  |  F18  |  F19  |  F20  |       |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * |       |  F9   |  F10  |  F11  |  F12  | XXXXX |-------            -------| XXXXX |  F21  |  F22  |  F23  |  F24  |       |
     *  -----------------------------------------------       |           \        -----------------------------------------------
     *                         |         | L_1     |  XXXXX  |             \  XXXXX  \ L_2     \         \
     *                        |         |         |         |               \         \         \         \
     *                        ------------------------------                 ------------------------------
     *  
     * Toggle Layer Keys:
     *              TAP     HOLD
     *      L_1 --> Tab     M_NAV
     *      L_2 --> ,       M_RAISE
     */
    // [T_FUNC] = LAYOUT_split_3x6_3(
    // // 6x3x2 (width, height, splits) ortholinear key group
    // //  #######,   #######,   #######,   #######,   #######,   #######,   SPLIT   #######,   #######,   #######,   #######,   #######,   #######,
    //     _______,   KC_F1,     KC_F2,     KC_F3,     KC_F4,     XXXXXXX,           XXXXXXX,   KC_F13,    KC_F14,    KC_F15,    KC_F16,    _______,
    //     _______,   KC_F5,     KC_F6,     KC_F7,     KC_F8,     XXXXXXX,           XXXXXXX,   KC_F17,    KC_F18,    KC_F19,    KC_F20,    _______,
    //     _______,   KC_F9,     KC_F10,    KC_F11,    KC_F12,    XXXXXXX,           XXXXXXX,   KC_F21,    KC_F22,    KC_F23,    KC_F24,    _______,
    // // 3x1x2 (width, height, splits) separated key group
    //                                       _______, TG(T_FUNC), XXXXXXX,           XXXXXXX, TG(T_FUNC), _______
    // ),

    /*
     * T_NUMPAD
     *  
     *  -----------------------------------------------                            -----------------------------------------------
     * |       |   /   |   7   |   8   |   9   |   -   |                          | XXXXX | Home  | Up    | Pg_Up | XXXXX |       |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * |       |   *   |   4   |   5   |   6   |   +   |                          | XXXXX | Left  | XXXXX | Right | XXXXX |       |
     * |-----------------------------------------------|                          |-----------------------------------------------|
     * |       |   0   |   1   |   2   |   3   |   .   |-------            -------|  Del  | End   | Down  | Pg_Dn |  Ins  |       |
     *  -----------------------------------------------       |           \        -----------------------------------------------
     *                         |         | L_1     | Space   |             \ Enter   \ L_2     \         \
     *                        |         |         |         |               \         \         \         \
     *                        ------------------------------                 ------------------------------
     *  
     * Toggle Layer Keys:
     *              TAP     HOLD
     *      L_1 --> Tab     M_NAV
     *      L_2 --> ,       M_RAISE
     */
    // [T_NUMPAD] = LAYOUT_split_3x6_3(
    // // 6x3x2 (width, height, splits) ortholinear key group
    // //  #######,   #######,   #######,   #######,   #######,   #######,   SPLIT   #######,   #######,   #######,   #######,   #######,   #######,
    //     _______,   KC_SLSH,   KC_7,      KC_8,      KC_9,      KC_MINS,           XXXXXXX,   KC_HOME,   KC_UP,     KC_PGUP,   XXXXXXX,   _______,
    //     _______,   KC_ASTR,   KC_4,      KC_5,      KC_6,      KC_PLUS,           XXXXXXX,   KC_LEFT,   KC_F18,    KC_RGHT,   XXXXXXX,   _______,
    //     _______,   KC_0,      KC_1,      KC_2,      KC_3,      KC_DOT,            KC_DEL,    KC_END,    KC_DOWN,   KC_PGDN,   KC_INS,    _______,
    // // 3x1x2 (width, height, splits) separated key group
    //                                     _______, TG(T_NUMPAD), KC_SPC,            KC_ENT, TG(T_NUMPAD), _______
    // ),

    /*
     * M_WINDOW
     *
     *  -----------------------------------------------                           -----------------------------------------------
     * | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX |                         | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX | XXXXX |
     * |-----------------------------------------------|                         |-----------------------------------------------|
     * | XXXXX |   Q   |   W   |   E   |   R   |   T   |                         |   Y   |   U   |   I   |   O   |   P   | XXXXX |
     * |-----------------------------------------------|-------           -------|-----------------------------------------------|
     * | L_SFT |   A   |   S   |   D   |   F   |   G   | XXXXX |         | XXXXX |   B   |   H   |   J   |   K   |   L   | R_SFT |
     * |-----------------------------------------------|       |         |       |-----------------------------------------------|
     * | XXXXX |   Z   |   X   |   C   |   V   | XXXXX |-------|         |-------| XXXXX |   N   |   M   | XXXXX | XXXXX | XXXXX |
     *  -----------------------------------------------       |           \       -----------------------------------------------
     *               |         | XXXXXXX | XXXXXXX | XXXXXXX |             \ XXXXXXX \ XXXXXXX \ XXXXXXX \         \
     *              |         |         |         |         |               \         \         \         \         \
     *              ----------------------------------------                 ----------------------------------------
     *
     */ 
    [M_WINDOW] = LAYOUT(
    // 6x4x2 (width, height, splits) +2 ortholinear key group
        XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,                           XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,   XXXXXXX,
        XXXXXXX,   KC_Q,      KC_W,      KC_E,      KC_R,      KC_T,                              KC_Y,      KC_U,      KC_I,      KC_O,      KC_P,      XXXXXXX,
        KC_LSFT,   KC_A,      KC_S,      KC_D,      KC_F,      KC_G,                              KC_B,      KC_H,      KC_J,      KC_K,      KC_L,      KC_RSFT,
        XXXXXXX,   KC_Z,      KC_X,      KC_C,      KC_V,      XXXXXXX,   XXXXXXX,     XXXXXXX,   XXXXXXX,   KC_N,      KC_M,      XXXXXXX,   XXXXXXX,   XXXXXXX,
    // 4x1x2 (width, height, splits) separated thumb key group
                                               _______, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, _______
    ),

    /*
     * _TR
     *
     *  -----------------------------------------------                           -----------------------------------------------
     * |       |       |       |       |       |       |                         |       |       |       |       |       |       |
     * |-----------------------------------------------|                         |-----------------------------------------------|
     * |       |       |       |       |       |       |                         |       |       |       |       |       |       |
     * |-----------------------------------------------|-------           -------|-----------------------------------------------|
     * |       |       |       |       |       |       |       |         |       |       |       |       |       |       |       |
     * |-----------------------------------------------|       |         |       |-----------------------------------------------|
     * |       |       |       |       |       |       |-------|         |-------|       |       |       |       |       |       |
     *  -----------------------------------------------       |           \       -----------------------------------------------
     *               |         |         |         |         |             \         \         \         \         \
     *              |         |         |         |         |               \         \         \         \         \
     *              ----------------------------------------                 ----------------------------------------
     *
     */ 
    [_TR] = LAYOUT(
    // 6x4x2 (width, height, splits) +2 ortholinear key group
        _______,   _______,   _______,   _______,   _______,   _______,                           _______,   _______,   _______,   _______,   _______,   _______,
        _______,   _______,   _______,   _______,   _______,   _______,                           _______,   _______,   _______,   _______,   _______,   _______,
        _______,   _______,   _______,   _______,   _______,   _______,                           _______,   _______,   _______,   _______,   _______,   _______,
        _______,   _______,   _______,   _______,   _______,   _______,   _______,     _______,   _______,   _______,   _______,   _______,   _______,   _______,
    // 4x1x2 (width, height, splits) separated thumb key group
                                               _______, _______, _______, _______,     _______, _______, _______, _______
    ),
};
