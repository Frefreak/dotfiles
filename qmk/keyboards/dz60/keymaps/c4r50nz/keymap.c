#include QMK_KEYBOARD_H

enum {
  TD_GRAVE_ESC = 0
};

//Tap Dance Definitions
qk_tap_dance_action_t tap_dance_actions[] = {
  //Tap once for Esc, twice for Caps Lock
  [TD_GRAVE_ESC]  = ACTION_TAP_DANCE_DOUBLE(KC_GRAVE, KC_ESC)
// Other declarations would go here, separated by commas, if you have them
};

#define MUTE		KC_AUDIO_MUTE
#define VOLUP		KC_AUDIO_VOL_UP
#define VOLDOWN		KC_AUDIO_VOL_DOWN

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	LAYOUT_60_ansi(
		TD(TD_GRAVE_ESC), KC_1,  KC_2,  KC_3,  KC_4,  KC_5,  KC_6,  KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_BSPC,
		KC_TAB,  KC_Q,    KC_W,  KC_E,  KC_R,  KC_T,  KC_Y,  KC_U,  KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_BSLS,
		KC_LCTL, KC_A,    KC_S,  KC_D,  KC_F,  KC_G,  KC_H,  KC_J,  KC_K,    KC_L,    KC_SCLN, KC_QUOT, KC_ENT,
		KC_LSFT, KC_Z,    KC_X,  KC_C,  KC_V,  KC_B,  KC_N,  KC_M,  KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT,
		KC_CAPS, KC_LGUI, KC_LALT,             LT(1, KC_SPC),                F(1),    F(2),    F(3),    KC_RCTL),
	// 1: Function Layer
	LAYOUT_60_ansi(
		KC_TRNS, KC_F1,   KC_F2,  KC_F3,   KC_F4, KC_F5, KC_F6, KC_F7, KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_TRNS,
		KC_TRNS, KC_KP_7, KC_KP_8,KC_KP_9, KC_DELETE,  KC_TRNS,  KC_TRNS,  KC_BSPC,  KC_WH_D, KC_WH_U,  KC_MPLY, KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS, KC_KP_4, KC_KP_5,KC_KP_6, KC_TRNS,  KC_TRNS,  KC_LEFT,  KC_DOWN,    KC_UP,    KC_RIGHT,    KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS, KC_KP_1, KC_KP_2,KC_KP_3, KC_TRNS,  VOLUP, VOLDOWN, MUTE, KC_TRNS,  KC_TRNS,  KC_TRNS, KC_TRNS,
		KC_TRNS, KC_NUMLOCK, KC_KP_0,                   KC_TRNS,                        KC_TRNS,  KC_TRNS, KC_TRNS,  KC_TRNS),
	// 2: Function Layer
	LAYOUT_60_ansi(
		RESET,KC_MS_ACCEL0,KC_MS_ACCEL1,KC_MS_ACCEL2,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,
		KC_TRNS, KC_WH_U, KC_MS_U, KC_WH_D, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_PSCR, KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS, KC_MS_L, KC_MS_D, KC_MS_R, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS, KC_MS_BTN1, KC_MS_BTN3, KC_MS_BTN2, KC_TRNS, BL_INC,  BL_STEP, KC_TRNS, KC_DEL,  KC_END,  KC_PGDN,          KC_TRNS,
		KC_TRNS, KC_TRNS, KC_TRNS,                   KC_TRNS,                            KC_TRNS, KC_TRNS,          KC_TRNS, KC_TRNS),
	// 3: Function Layer
	LAYOUT_60_ansi(
		RGB_TOG,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_DEL,
		KC_TAB,   KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I,    KC_O,   KC_P,     KC_LBRC, KC_RBRC, KC_BSLS,
		KC_CAPS,  KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K,    KC_L,   KC_SCLN,  KC_QUOT, KC_ENT,
		KC_LSFT,  KC_Z, KC_X, KC_Z, KC_V, KC_B, KC_N, KC_M, KC_COMM, KC_DOT, KC_SLSH,  KC_RSFT,
		KC_TRNS,  KC_TRNS,          KC_TRNS,                KC_SPC,                    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS)
};

// Custom Actions
const uint16_t PROGMEM fn_actions[] = {
    [0] = ACTION_LAYER_MOMENTARY(1),  // to F1 overlay
    [1] = ACTION_LAYER_MOMENTARY(2),  // to F2 overlay
    [2] = ACTION_LAYER_MOMENTARY(3),  // to F3 overlay
    [3] = ACTION_LAYER_MOMENTARY(4),  // to F4 overlay
};
