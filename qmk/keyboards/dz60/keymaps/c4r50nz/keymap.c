#include QMK_KEYBOARD_H

enum {
  TD_GRAVE_ESC = 0
};

//Tap Dance Definitions
tap_dance_action_t tap_dance_actions[] = {
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
		KC_CAPS, KC_LGUI, KC_LALT,             LT(1, KC_SPC),                MO(2),    TG(3),    MO(4),    KC_RCTL),
	// 1: Function Layer
	LAYOUT_60_ansi(
		KC_TRNS, KC_F1,   KC_F2,  KC_F3,   KC_F4, KC_F5, KC_F6, KC_F7, KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_TRNS,
		KC_TRNS, KC_7, KC_8,KC_9, KC_DELETE,  KC_TRNS,  KC_TRNS,  KC_BSPC,  KC_WH_D, KC_WH_U,  KC_MPLY, KC_PAGE_UP, KC_PAGE_DOWN, KC_TRNS,
		KC_TRNS, KC_4, KC_5,KC_6, KC_TRNS,  KC_TRNS,  KC_LEFT,  KC_DOWN,    KC_UP,    KC_RIGHT,    KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS, KC_1, KC_2,KC_3, KC_TRNS,  VOLUP, VOLDOWN, MUTE, KC_HOME,  KC_END,  KC_TRNS, KC_TRNS,
		KC_TRNS, KC_TRNS, KC_0,                   KC_TRNS,                        KC_TRNS,  KC_TRNS, KC_TRNS,  KC_TRNS),
	// 2: Function Layer
	LAYOUT_60_ansi(
		QK_BOOT,KC_MS_ACCEL0,KC_MS_ACCEL1,KC_MS_ACCEL2,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,
		KC_TRNS, KC_WH_U, KC_MS_U, KC_WH_D, RGB_TOG, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_PSCR, KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS, KC_MS_L, KC_MS_D, KC_MS_R, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS, KC_MS_BTN1, KC_MS_BTN3, KC_MS_BTN2, KC_TRNS, BL_UP,  BL_STEP, KC_TRNS, KC_HOME,  KC_END,  KC_TRNS,          KC_TRNS,
		KC_TRNS, KC_TRNS, KC_TRNS,                   KC_TRNS,                            KC_TRNS, KC_TRNS,          KC_TRNS, KC_TRNS),

	// 3: (minecraft)
	LAYOUT_60_ansi(
		KC_ESC,  KC_1,   KC_2,   KC_3,   KC_4,   KC_5,   KC_6,   KC_7,   KC_8,   KC_9,   KC_0,  KC_MINS,  KC_EQL,  KC_BSPC,
		KC_TAB,   KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I,    KC_O,   KC_P,     KC_LBRC, KC_RBRC, KC_BSLS,
		KC_LCTL,  KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K,    KC_L,   KC_SCLN,  KC_QUOT, KC_ENT,
		KC_LSFT,  KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M, KC_COMM, KC_DOT, KC_SLSH,  KC_RSFT,
		KC_CAPS,  KC_GRAVE,          KC_LALT,                KC_SPC,                    MO(4), KC_TRNS, MO(5), KC_TRNS),
	// almost same as Layer 1
	// 4: Function Layer
	LAYOUT_60_ansi(
		KC_TRNS, KC_F1,   KC_F2,  KC_F3,   KC_F4, KC_F5, KC_F6, KC_F7, KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_TRNS,
		KC_TRNS, KC_7, KC_8,KC_9, KC_DELETE,  KC_TRNS,  KC_TRNS,  KC_BSPC,  KC_WH_D, KC_WH_U,  KC_MPLY, KC_PAGE_UP, KC_PAGE_DOWN, KC_TRNS,
		KC_TRNS, KC_4, KC_5,KC_6, KC_TRNS,  KC_TRNS,  KC_LEFT,  KC_DOWN,    KC_UP,    KC_RIGHT,    KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS, KC_1, KC_2,KC_3, KC_TRNS,  VOLUP, VOLDOWN, MUTE, KC_TRNS,  KC_TRNS,  KC_TRNS, KC_TRNS,
		KC_TRNS, KC_TRNS, KC_0,                   KC_TRNS,                        KC_TRNS,  KC_TRNS, KC_TRNS,  KC_TRNS),
	// 5: F-keys
	LAYOUT_60_ansi(
		KC_TRNS,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_TRNS,
		KC_TRNS,  KC_7, KC_8, KC_9, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,    KC_TRNS,   KC_TRNS,     KC_TRNS, KC_TRNS, KC_TRNS,
		KC_TRNS,  KC_4, KC_5, KC_6, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,    KC_TRNS,   KC_TRNS,  KC_TRNS, KC_TRNS,
		KC_TRNS,  KC_1, KC_2, KC_3, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,
		KC_TRNS,  KC_TRNS,          KC_0,                KC_TRNS,                    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
};
