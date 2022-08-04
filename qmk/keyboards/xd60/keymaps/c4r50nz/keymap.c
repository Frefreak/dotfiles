#include QMK_KEYBOARD_H
#include "action_layer.h"

#define Z64_Layout( \
      K00,  K01,  K02,  K03,  K04,  K05,  K06,  K07,  K08,  K09,  K0A,  K0B,  K0C,  K0D,       \
      K10,  K11,  K12,  K13,  K14,  K15,  K16,  K17,  K18,  K19,  K1A,  K1B,  K1C,  K1D,       \
      K20,  K21,  K22,  K23,  K24,  K25,  K26,  K27,  K28,  K29,  K2A,  K2B,        K2D,       \
      K30,        K32,  K33,  K34,  K35,  K36,  K37,  K38,  K39,  K3A,  K3B,        K3D,       \
      K40,  K41,  K42,              K45,  K49,                    K4A,  K4B,  K4C,  K4D        \
) { \
{ K00, K01, K02, K03, K04, K05, K06, K07, K08, K09, K0A, K0B, K0C, K0D }, \
{ K10, K11, K12, K13, K14, K15, K16, K17, K18, K19, K1A, K1B, K1C, K1D }, \
{ K20, K21, K22, K23, K24, K25, K26, K27, K28, K29, K2A, K2B, KC_NO,    K2D }, \
{ K30, KC_NO,    K32, K33, K34, K35, K36, K37, K38, K39, K3A, K3B, KC_NO,    K3D }, \
{ K40, K41, K42, KC_NO,    KC_NO,    K45, KC_NO,    KC_NO,    KC_NO,    K49, K4A, K4B, K4C, K4D }  \
}

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
#define PLAY_TOG	KC_MEDIA_PLAY_PAUSE
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  // 0: Base Layer
  Z64_Layout(
      TD(TD_GRAVE_ESC), KC_1,    KC_2,    KC_3,   KC_4,   KC_5,   KC_6,   KC_7,   KC_8,    KC_9,    KC_0,     KC_MINS, KC_EQL,  KC_BSPC,\
      KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,   KC_T,   KC_Y,   KC_U,   KC_I,   KC_O,    KC_P,    KC_LBRC,  KC_RBRC, KC_BSLS,		\
      KC_CAPS, KC_A,    KC_S,    KC_D,    KC_F,   KC_G,   KC_H,   KC_J,   KC_K,   KC_L,    KC_SCLN, KC_QUOT,  KC_ENT,			\
      KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,   KC_B,   KC_N,   KC_M,   KC_COMM,KC_DOT,  KC_SLSH, KC_RSFT,				\
      KC_LCTL, KC_LGUI, KC_LALT,                  KC_SPC,                         MO(1),    MO(2),    TG(3),  MO(4), KC_RCTL),

  // 1: Function Layer
  Z64_Layout(
      KC_TRNS, KC_F1,   KC_F2,   KC_F3,   KC_F4,  KC_F5,  KC_F6,  KC_F7,  KC_F8,  KC_F9,   KC_F10,  KC_F11,   KC_F12,  KC_TRNS,         \
      KC_TRNS, KC_KP_7, KC_KP_8, KC_KP_9, KC_DELETE,KC_TRNS,KC_TRNS,KC_BSPC,KC_WH_D,KC_WH_U, KC_TRNS,KC_TRNS,  KC_TRNS, KC_TRNS,         \
      KC_TRNS, KC_KP_4, KC_KP_5, KC_KP_6, KC_TRNS,KC_TRNS,KC_LEFT,KC_DOWN,KC_UP,  KC_RIGHT,KC_TRNS, KC_TRNS,  KC_TRNS,			\
      KC_TRNS, KC_KP_1, KC_KP_2, KC_KP_3, KC_TRNS,VOLUP,  VOLDOWN,MUTE,   KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS,				\
      KC_TRNS, KC_TRNS, KC_KP_0,		  KC_TRNS,			  KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS, KC_TRNS),

  // 2: Function Layer2
  Z64_Layout(
      RESET, KC_MS_ACCEL0,KC_MS_ACCEL1,KC_MS_ACCEL2, KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS, KC_TRNS,         \
      KC_TRNS, KC_WH_U, KC_MS_U, KC_WH_D, KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS, KC_TRNS,         \
      KC_TRNS, KC_MS_L, KC_MS_D, KC_MS_R, KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,			\
      KC_TRNS, KC_MS_BTN1, KC_MS_BTN3, KC_MS_BTN2, KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS,				\
      KC_TRNS, KC_TRNS, KC_TRNS,		  KC_TRNS,			  KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS, KC_TRNS),

 // 3: Function Layer 3, used for F-keys for now
  Z64_Layout(
      KC_TRNS, KC_F1,   KC_F2,   KC_F3,   KC_F4,  KC_F5,  KC_F6,  KC_F7,  KC_F8,  KC_F9,   KC_F10,  KC_F11,   KC_F12,  KC_TRNS,         \
      KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS, KC_TRNS,         \
      KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,			\
      KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS,				\
      KC_TRNS, KC_TRNS, KC_TRNS,		  KC_TRNS,			  KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS, KC_TRNS)
};

uint16_t *key_logs = NULL;

bool keylog_enabled = false;
uint16_t offset = 0;

/* void matrix_init_user(void) { */
	/* key_logs = malloc(512); */
/* } */


/* bool process_record_user(uint16_t keycode, keyrecord_t *record) { */
	/* if (key_logs == NULL) */
		/* return true; */
	/* switch (keycode) { */
		/* case KC_RSFT: */
			/* if (record->event.pressed) { */
				/* if (!keylog_enabled) */
					/* offset = 0; */
				/* keylog_enabled ^= 1; */
			/* } */
			/* return false; */
		/* case KC_RCTL: */
			/* if (record->event.pressed) { */
				/* for (uint16_t i = 0; i < offset; i += 1) { */
					/* register_code(key_logs[i]); */
					/* unregister_code(key_logs[i]); */
				/* } */
			/* } */
		/* default: */
			/* if (record->event.pressed) { */
				/* if (keylog_enabled && offset < 256) */
					/* key_logs[offset++] = keycode; */
			/* } */
			/* return true; */
	/* } */
/* } */
