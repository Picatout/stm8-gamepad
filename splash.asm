;----------------------
;  splash screen
;----------------------
BYTES_PER_IMG_ROW=25
IMG_DATA_SIZE=4800
	.area CODE

img_data:
	.byte 0xBF, 0xF5, 0x57, 0x50, 0x00, 0x05, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0xD5, 0xEB, 0xFD, 0xFF, 0xDD, 0xFF
	.byte 0xD5, 0x5F, 0xF9, 0x00, 0x00, 0x08, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x02, 0xBE, 0xAA, 0xFF, 0xFF, 0xFF, 0xEB
	.byte 0x7F, 0xF5, 0x6E, 0xA0, 0x00, 0x02, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x4B, 0xD7, 0xB7, 0xB5, 0x77, 0x7F
	.byte 0xD5, 0x5F, 0xDA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x35, 0x6B, 0xFE, 0xFF, 0xFD, 0xDF
	.byte 0xBF, 0xFB, 0x76, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0xD5, 0xFF, 0xFF, 0xDF, 0xFB
	.byte 0xD5, 0x5E, 0xDA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2A, 0xD7, 0x5B, 0xDB, 0x77, 0xBF
	.byte 0x7F, 0xFB, 0x6A, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xA1, 0xFF, 0x7F, 0xFE, 0xFF
	.byte 0xD5, 0x57, 0xD2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x56, 0xFF, 0xFD, 0xDF, 0xEB
	.byte 0xBF, 0xFD, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x81, 0xB7, 0xDF, 0xFD, 0xBF
	.byte 0xEA, 0xAF, 0xD8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x45, 0xFE, 0xF7, 0x77, 0xFF
	.byte 0x5F, 0xFD, 0x6A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x01, 0x00, 0xBF, 0xFF, 0xFF, 0xEF
	.byte 0xEA, 0xAF, 0xD4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xFB, 0xEE, 0xEE, 0xBB
	.byte 0xBF, 0xFD, 0xB8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2F, 0x7F, 0xFF, 0xFF
	.byte 0xD5, 0x6F, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xFF, 0xFB, 0xBB, 0xF7
	.byte 0x7F, 0xB5, 0xD8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x37, 0xDF, 0xFF, 0x7F
	.byte 0xAB, 0xFE, 0xA2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFE, 0xF7, 0x77, 0xDF
	.byte 0xFD, 0x55, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x5F, 0xFF, 0xFF, 0xF7
	.byte 0xAF, 0xFF, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFB, 0xDE, 0xEE, 0xFF
	.byte 0xFB, 0xAD, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2F, 0xFF, 0xFF, 0xBB
	.byte 0xAE, 0xFA, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x77, 0xBB, 0xFF
	.byte 0xFB, 0x77, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1B, 0xFD, 0xFF, 0x6F
	.byte 0xBF, 0xDD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x04, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xDF, 0x77, 0xFF
	.byte 0xED, 0x7B, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x52, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2E, 0xFF, 0xFF, 0xF7
	.byte 0xBB, 0xDE, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x36, 0xA0, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0xFD, 0xEE, 0xBD
	.byte 0xEF, 0x6B, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2D, 0xD5, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1B, 0xB7, 0xBF, 0xFF
	.byte 0xBB, 0xFE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x5A, 0xBB, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFD, 0xF7
	.byte 0xEF, 0xAD, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6F, 0xD6, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2E, 0xFD, 0xEF, 0xBF
	.byte 0xBA, 0xFA, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x5A, 0xBB, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xDF, 0xFB, 0xEF
	.byte 0xEF, 0x6F, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0xEE, 0xAC, 0x00, 0x00, 0x00, 0x1B, 0xB4, 0x00, 0x2F, 0xF7, 0xBF, 0xFF
	.byte 0xBB, 0xFA, 0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0xB5, 0x52, 0x05, 0x00, 0x05, 0xFF, 0xFE, 0x80, 0xBB, 0x7E, 0xEE, 0xDB
	.byte 0xEF, 0xAF, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x11, 0x5A, 0xAD, 0x5A, 0x80, 0x57, 0xEC, 0x02, 0x80, 0x2F, 0xFF, 0xFF, 0xFF
	.byte 0xBA, 0xFA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x25, 0x6A, 0xAA, 0xEA, 0x20, 0xBF, 0x52, 0x17, 0xE0, 0x7F, 0xF7, 0xDB, 0xBF
	.byte 0xEF, 0xD7, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x8A, 0xDA, 0xAB, 0x55, 0x43, 0xF5, 0x60, 0x4A, 0xB4, 0x55, 0xBD, 0xFF, 0xF7
	.byte 0xBA, 0xFD, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6A, 0xB6, 0xDA, 0xAA, 0xAD, 0xFD, 0x08, 0x01, 0x7C, 0x3F, 0xFF, 0x7E, 0xFF
	.byte 0xEF, 0xD6, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x17, 0xD5, 0xB5, 0x6A, 0xAF, 0x5B, 0xF2, 0x04, 0x0F, 0x5F, 0xEF, 0xFB, 0xDB
	.byte 0xBA, 0xFC, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x5D, 0x7A, 0xEE, 0xA9, 0x7F, 0xF6, 0xDA, 0x40, 0x07, 0x37, 0x7D, 0xDF, 0xFF
	.byte 0xEF, 0xF7, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x37, 0xD7, 0xDD, 0x5A, 0xB6, 0xDF, 0x7A, 0xA0, 0x20, 0xDB, 0xFF, 0xF6, 0xFF
	.byte 0xBB, 0xBD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x5D, 0x7A, 0xF7, 0xEB, 0xFF, 0xFB, 0xC5, 0x00, 0x02, 0xDF, 0xF7, 0x7F, 0xAF
	.byte 0xEE, 0xD7, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x77, 0xEF, 0xBE, 0xDF, 0xDB, 0x6F, 0x7C, 0x00, 0x00, 0x6D, 0xBF, 0xFF, 0xFB
	.byte 0xBB, 0xFD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2A, 0xDD, 0x7B, 0x6B, 0xFB, 0x7F, 0xFB, 0xD1, 0x00, 0x00, 0x3F, 0xFD, 0xF6, 0xFF
	.byte 0xEF, 0x77, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17, 0x77, 0xAD, 0xFF, 0x6F, 0xFE, 0xDF, 0x54, 0x00, 0x02, 0x37, 0xEF, 0xDF, 0xBF
	.byte 0xBB, 0xDD, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAD, 0xAD, 0xFF, 0x5F, 0xFB, 0xEF, 0xFB, 0xD8, 0x00, 0x00, 0x1E, 0xFF, 0x7F, 0xF7
	.byte 0xED, 0x7F, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0xDB, 0x7E, 0xEB, 0xF5, 0xEF, 0x7B, 0x6E, 0xF4, 0x00, 0x00, 0x0B, 0xFB, 0xF6, 0xFF
	.byte 0xBF, 0xEA, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0xFF, 0xDB, 0xBE, 0xFF, 0x5B, 0xDF, 0xFF, 0xA0, 0x00, 0x00, 0x0F, 0xDF, 0xFF, 0xBF
	.byte 0xEB, 0xBF, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0xAD, 0x6E, 0xDB, 0x7F, 0xFF, 0xFD, 0xBB, 0x68, 0x00, 0x00, 0x06, 0xFF, 0x6F, 0xEB
	.byte 0xBE, 0xEE, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x05, 0xFF, 0xFB, 0xFF, 0xEE, 0xAF, 0x7F, 0xEE, 0xD0, 0x00, 0x00, 0x07, 0xFD, 0xFD, 0xFF
	.byte 0xFB, 0x7B, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0x77, 0x5F, 0x6D, 0xBB, 0xF7, 0xDB, 0x7F, 0xD0, 0x00, 0x00, 0x07, 0xBF, 0xFF, 0x7F
	.byte 0xAF, 0xDF, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1D, 0xDD, 0xEB, 0xFF, 0xFE, 0xBD, 0xFF, 0xED, 0xA0, 0x00, 0x00, 0x0F, 0xF7, 0xB7, 0xDB
	.byte 0xFA, 0xFD, 0xB0, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x17, 0x77, 0xBF, 0xAE, 0xED, 0xFF, 0xFB, 0xBF, 0xF8, 0x00, 0x00, 0x05, 0xFF, 0xFF, 0xFF
	.byte 0xAF, 0xAF, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0xDD, 0x76, 0xFB, 0xFA, 0xB7, 0xBF, 0xEE, 0xE0, 0x00, 0x00, 0x0F, 0x7D, 0xFD, 0xBF
	.byte 0xFE, 0xFB, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x77, 0xDF, 0xBF, 0xB5, 0xFD, 0xEE, 0xFF, 0xBD, 0x00, 0x00, 0x15, 0xDF, 0xEF, 0xF7
	.byte 0xBB, 0xBF, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0xDD, 0xF5, 0xED, 0xFA, 0xDF, 0xFF, 0xDB, 0xEA, 0x10, 0x00, 0x37, 0xFF, 0xBF, 0xFF
	.byte 0xED, 0xFD, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x92, 0x77, 0x5F, 0xB7, 0xEF, 0xFF, 0x7B, 0x7F, 0x7E, 0x84, 0x00, 0x2A, 0xFD, 0xFB, 0x7F
	.byte 0xBF, 0x57, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2F, 0xDD, 0xEB, 0xFF, 0xBA, 0xBB, 0xDF, 0xFF, 0xDA, 0x00, 0x12, 0xE3, 0xEF, 0xFF, 0xDB
	.byte 0xF5, 0xFF, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5A, 0xB7, 0xBD, 0x5B, 0xFF, 0xFF, 0xFF, 0xB7, 0xFF, 0x20, 0x01, 0x75, 0x7F, 0xDF, 0xFF
	.byte 0xAF, 0x6D, 0xE8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17, 0xDA, 0xEF, 0xFF, 0x6B, 0x77, 0x77, 0xFE, 0xD1, 0xD2, 0x4D, 0xE3, 0xFF, 0x7B, 0x6F
	.byte 0xFD, 0xFF, 0xB8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0xAF, 0xBD, 0xBF, 0xFF, 0xFF, 0xFD, 0xFF, 0xFA, 0xAD, 0x3B, 0xE1, 0x5B, 0xFF, 0xFF
	.byte 0xAF, 0x5B, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0xF5, 0xEF, 0xED, 0xFE, 0xDD, 0xDF, 0xB7, 0xA7, 0xF3, 0xEE, 0xC5, 0xFF, 0xEF, 0xFB
	.byte 0xFD, 0xFE, 0xDC, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x15, 0x5F, 0x55, 0x7F, 0xD7, 0xFF, 0xFF, 0xFD, 0x7E, 0xDD, 0xB7, 0xC0, 0xFF, 0x7D, 0xBF
	.byte 0xDB, 0x6F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xF5, 0xFF, 0xFF, 0x7D, 0xFF, 0x76, 0xDF, 0xDB, 0xF6, 0xFF, 0xC1, 0xB7, 0xFF, 0xEF
	.byte 0x7F, 0xFA, 0xEC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x5F, 0x55, 0xAB, 0xFF, 0xAB, 0xFF, 0xFF, 0xFF, 0xAB, 0xDB, 0xC0, 0x5F, 0xDF, 0xFF
	.byte 0xD5, 0x5F, 0xD8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xF5, 0xFF, 0xFE, 0xF7, 0xFF, 0xDB, 0xF6, 0xFE, 0xFE, 0xBF, 0x40, 0x7D, 0xFE, 0xDF
	.byte 0x7F, 0xFF, 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xDF, 0x56, 0xFF, 0xDD, 0xFE, 0xFF, 0xBF, 0xB7, 0xD5, 0xFF, 0x80, 0xAF, 0xFB, 0xFB
	.byte 0xD5, 0x75, 0xEC, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x05, 0x6B, 0xFF, 0xDB, 0xFF, 0xDB, 0xFE, 0xFF, 0xFE, 0xFF, 0x77, 0x80, 0x7F, 0x6F, 0xFF
	.byte 0xBF, 0xDF, 0xBD, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x01, 0x5E, 0xDD, 0x7F, 0x77, 0x7F, 0xB7, 0xFB, 0xDB, 0xD5, 0xDF, 0x00, 0x1B, 0xFE, 0xDF
	.byte 0xEA, 0xF7, 0xEA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xF7, 0xF7, 0xEF, 0xFF, 0xFF, 0xFD, 0xAE, 0xFF, 0x7F, 0xFE, 0x80, 0x7F, 0xFF, 0xF7
	.byte 0xBF, 0xDD, 0x7D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x0A, 0xDE, 0xDF, 0x7D, 0xDD, 0xB7, 0x7F, 0xFF, 0xED, 0xD6, 0xEF, 0x60, 0x0E, 0xDD, 0xFF
	.byte 0xD5, 0x77, 0xDE, 0x00, 0x00, 0x40, 0x00, 0x02, 0x00, 0x00, 0x03, 0xFB, 0xF7, 0xDF, 0xFF, 0xFD, 0xEB, 0x7D, 0xFF, 0x7F, 0xBD, 0x80, 0x3B, 0xFF, 0xDF
	.byte 0x7F, 0xDE, 0xFB, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x05, 0x6F, 0x5D, 0xFF, 0x77, 0xFF, 0xFF, 0xEF, 0xFD, 0xEB, 0xFF, 0x40, 0x0F, 0xF7, 0x7B
	.byte 0xD5, 0x77, 0xB6, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xDB, 0xFF, 0xBB, 0xFE, 0xDB, 0xDF, 0x7F, 0x57, 0x7E, 0xFB, 0x90, 0x2F, 0xBF, 0xFF
	.byte 0xBF, 0xDE, 0xFE, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x15, 0xBF, 0xED, 0xFF, 0xDF, 0xFF, 0x7D, 0xF5, 0xFF, 0xFF, 0xBF, 0x40, 0x02, 0xFD, 0xEF
	.byte 0xED, 0xF7, 0xB7, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4B, 0x6D, 0xBF, 0x6F, 0xFB, 0xFF, 0xF7, 0xBF, 0xFD, 0x6D, 0xFD, 0x80, 0x0F, 0xFF, 0xBF
	.byte 0xB7, 0x5E, 0xFD, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xFF, 0xED, 0xFF, 0x7F, 0x7B, 0xBE, 0xFE, 0xEF, 0xFF, 0xEF, 0x50, 0x05, 0xB7, 0xFB
	.byte 0xDD, 0xEB, 0xAF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1A, 0xED, 0x7F, 0xFD, 0xEF, 0xEF, 0xEF, 0xEF, 0xBB, 0xBB, 0xFE, 0xC0, 0x17, 0xFE, 0xFF
	.byte 0x76, 0xBE, 0xFD, 0xC0, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x17, 0xBF, 0xF5, 0x5F, 0xFF, 0xFE, 0xFE, 0xBB, 0xFF, 0xFF, 0x7B, 0xB4, 0x82, 0xFF, 0xEF
	.byte 0xDD, 0xEF, 0xBB, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xFF, 0xF7, 0xFF, 0xF7, 0x7B, 0x7F, 0xB7, 0xFF, 0x6D, 0xEF, 0xFF, 0xEA, 0x07, 0xDB, 0xBF
	.byte 0x77, 0xBA, 0xDF, 0xD0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0xBE, 0xAF, 0xFF, 0xDF, 0xDF, 0xFF, 0xED, 0xFF, 0x7F, 0xED, 0xBC, 0x0B, 0xFF, 0xFB
	.byte 0xAD, 0x6F, 0xF6, 0xA0, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x5F, 0x6B, 0xFA, 0xAE, 0xFF, 0xF6, 0xFE, 0xBF, 0xFF, 0xFB, 0xBF, 0xF5, 0x96, 0xFE, 0xFF
	.byte 0xF7, 0xDD, 0x5F, 0xE8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x07, 0xFF, 0xEF, 0xFF, 0xFB, 0x7F, 0xB7, 0xEF, 0x6D, 0xDF, 0xFB, 0xDB, 0x4B, 0xB7, 0xEF
	.byte 0xBA, 0xF7, 0xF6, 0xA0, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x3A, 0xEE, 0xBB, 0x7D, 0xEF, 0xEF, 0xFF, 0x7D, 0xFF, 0xFE, 0xFF, 0x7D, 0x45, 0xFF, 0x7F
	.byte 0xD7, 0x5D, 0x5B, 0xF0, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x07, 0x7B, 0xFF, 0xEF, 0xBE, 0xFB, 0xDD, 0xF7, 0xFB, 0x77, 0xFB, 0xF7, 0x87, 0xFB, 0xDB
	.byte 0xBD, 0xEF, 0xFE, 0xA4, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x5B, 0xDF, 0xED, 0xBB, 0xFF, 0xBF, 0x77, 0x5D, 0xBF, 0xFF, 0xDE, 0xEC, 0x0B, 0x5E, 0xFF
	.byte 0xEB, 0xBA, 0xAB, 0xF0, 0x00, 0x00, 0x20, 0x08, 0x00, 0x00, 0x05, 0x7A, 0xBF, 0xFF, 0x6F, 0xFD, 0xDD, 0xEF, 0xEF, 0xFD, 0xFF, 0xF9, 0x15, 0xFB, 0xB7
	.byte 0xBD, 0x6F, 0xFE, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0xDF, 0xFD, 0xD7, 0xFB, 0x6F, 0xE3, 0x57, 0xFD, 0xBF, 0x7D, 0xAA, 0x8F, 0x76, 0xED
	.byte 0xD7, 0xBA, 0xAB, 0xF4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x75, 0xEF, 0x7F, 0xBF, 0xFE, 0xD2, 0xEB, 0x7F, 0xFB, 0xFF, 0xF8, 0x2B, 0xDD, 0x57
	.byte 0xBA, 0xEF, 0xFE, 0xB8, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x05, 0x3F, 0x7F, 0xFB, 0xF6, 0xDB, 0xE1, 0x5F, 0xEF, 0xE6, 0xEF, 0x69, 0x16, 0xF6, 0xBB
	.byte 0x77, 0xBA, 0xAB, 0xEE, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x8B, 0xDB, 0x5E, 0xFF, 0xFC, 0x01, 0x55, 0xFF, 0xFB, 0xFB, 0xF4, 0x0B, 0xA9, 0x03
	.byte 0xDA, 0xD7, 0xFE, 0xD8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5E, 0xFE, 0xF7, 0xDF, 0x80, 0x00, 0x6F, 0xBB, 0xA2, 0xFF, 0xA0, 0x1F, 0xF4, 0x51
	.byte 0x6F, 0x7E, 0xAB, 0xF6, 0x80, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x2B, 0xFF, 0xDF, 0xFF, 0x00, 0x00, 0xB7, 0xFE, 0xF0, 0x3E, 0xE0, 0x2E, 0xAA, 0x00
	.byte 0xD5, 0xAB, 0xFE, 0xBC, 0x00, 0x00, 0x00, 0x00, 0x40, 0x10, 0x00, 0x0E, 0xDA, 0xFB, 0x78, 0x00, 0x01, 0x5E, 0xFF, 0xD0, 0x3F, 0xA0, 0x1B, 0xF0, 0x00
	.byte 0xBE, 0xFE, 0xAB, 0xF7, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x0B, 0xFF, 0xAF, 0xFC, 0x00, 0x80, 0x6B, 0xB7, 0xD0, 0x0F, 0xC0, 0x2F, 0xAA, 0x00
	.byte 0xD7, 0x57, 0xFE, 0xFD, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x02, 0xF6, 0xFF, 0xE0, 0x00, 0x00, 0xFF, 0xFE, 0x80, 0x07, 0x40, 0x1F, 0xF0, 0x00
	.byte 0xBD, 0xFA, 0xAB, 0xAE, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xBF, 0x5D, 0xB0, 0xB0, 0x01, 0xDD, 0xFF, 0xD0, 0x07, 0xE0, 0x97, 0x6C, 0x00
	.byte 0xEB, 0x5F, 0xFE, 0xFB, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0xF7, 0xC0, 0x04, 0x05, 0x77, 0xDB, 0xF4, 0x03, 0x80, 0x3F, 0xD0, 0x00
	.byte 0x5E, 0xF5, 0x5B, 0xEE, 0x80, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x02, 0x5F, 0x40, 0x92, 0x17, 0xFE, 0xFF, 0x5C, 0x03, 0xE0, 0x3D, 0xEA, 0x00
	.byte 0xEB, 0xAF, 0xF6, 0xBD, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0xC0, 0xA0, 0xB5, 0xF7, 0xEF, 0xF7, 0x17, 0x40, 0xFF, 0x50, 0x00
	.byte 0x5D, 0x7D, 0x5F, 0xF7, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xBB, 0xF6, 0x43, 0xDF, 0xBE, 0xFF, 0x5D, 0xA9, 0xC1, 0x2F, 0xE8, 0x00
	.byte 0xEB, 0xD7, 0xF5, 0x6D, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2F, 0xDF, 0xBE, 0xF9, 0xFF, 0xDD, 0xF7, 0xD7, 0xC0, 0xFA, 0xA2, 0x00
	.byte 0x5E, 0xBD, 0xAF, 0xFF, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5E, 0xFB, 0xFF, 0x66, 0xDF, 0x7F, 0xDE, 0xFD, 0x80, 0x1F, 0xD4, 0x00
	.byte 0xEB, 0x6B, 0x7A, 0xD5, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xFF, 0xFB, 0xFB, 0x77, 0xFB, 0x77, 0xFF, 0xC0, 0xD6, 0xA0, 0x00
	.byte 0x55, 0xDE, 0xEF, 0x7F, 0xA0, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x11, 0x00, 0x12, 0xBF, 0x6F, 0xB6, 0xFF, 0xDF, 0xFF, 0xBF, 0xA0, 0x3B, 0x40, 0x00
	.byte 0xBE, 0xB7, 0xBB, 0xAD, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x05, 0x7F, 0xFF, 0x6D, 0x6E, 0xF6, 0xEE, 0xF7, 0xC0, 0x2D, 0x50, 0x00
	.byte 0xD5, 0xDA, 0xEE, 0xF7, 0xA0, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0xF5, 0xFF, 0xFF, 0xFF, 0xBB, 0xFF, 0xC0, 0x56, 0x84, 0x00
	.byte 0x5A, 0xB7, 0x5B, 0xBA, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA6, 0x8F, 0xDA, 0xDD, 0xAD, 0xFF, 0xDD, 0x00, 0xA9, 0x40, 0x00
	.byte 0xF7, 0x6D, 0xEE, 0xD7, 0xD0, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x5D, 0x7F, 0xFF, 0xFF, 0xDD, 0xFF, 0x80, 0x26, 0x10, 0x00
	.byte 0x5A, 0xDB, 0x7B, 0x7A, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x13, 0xEB, 0xB6, 0xDB, 0x7F, 0x7A, 0x00, 0x59, 0x00, 0x00
	.byte 0xA7, 0x6D, 0xAD, 0x95, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x80, 0x00, 0x00, 0x00, 0x02, 0xBF, 0xFF, 0xFF, 0xEF, 0xEF, 0x40, 0x42, 0x40, 0x00
	.byte 0xFA, 0xDB, 0x76, 0xF6, 0xD0, 0x00, 0x00, 0x09, 0x00, 0x01, 0x41, 0x00, 0x00, 0x00, 0x0A, 0x6B, 0xFE, 0xB6, 0xB6, 0xFD, 0xFB, 0x00, 0x29, 0x00, 0x00
	.byte 0x55, 0xAD, 0xDB, 0xAD, 0x54, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x57, 0xFF, 0xFF, 0xFF, 0xF4, 0x00, 0x54, 0x24, 0x00
	.byte 0xEB, 0x76, 0xEC, 0xD5, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xD5, 0x7D, 0x6B, 0x6D, 0xB7, 0xDA, 0x80, 0x12, 0x80, 0x00
	.byte 0x5E, 0xDB, 0xB7, 0xAA, 0xD5, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD7, 0xFF, 0xFF, 0xFF, 0x74, 0x00, 0x2A, 0x00, 0x00
	.byte 0xEB, 0x6D, 0x6A, 0xB5, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xBD, 0xAE, 0xF6, 0xDF, 0xE9, 0x00, 0x24, 0x90, 0x00
	.byte 0x5D, 0xB7, 0xBD, 0xAB, 0x5A, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x52, 0xD7, 0x7F, 0xDF, 0xFD, 0xD4, 0xA0, 0x2B, 0x00, 0x00
	.byte 0xEA, 0xED, 0xD6, 0xD5, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x5B, 0xFF, 0xF7, 0xAA, 0x20, 0x08, 0x40, 0x00
	.byte 0x5F, 0xB6, 0xBB, 0x5A, 0xD5, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24, 0x7E, 0xED, 0x5E, 0xB7, 0x54, 0x52, 0x94, 0x00
	.byte 0xEA, 0xDD, 0xEA, 0xD6, 0xB4, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0xEF, 0xFF, 0xF5, 0x4A, 0xB1, 0x09, 0x00, 0x00
	.byte 0x5F, 0x77, 0x5F, 0x6D, 0xDA, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x40, 0x00, 0x00, 0x00, 0x08, 0xB7, 0x7F, 0xBC, 0x00, 0x00, 0x54, 0x40, 0x00
	.byte 0xEB, 0xDA, 0xEA, 0xB6, 0xAC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x40, 0x00, 0x00, 0x15, 0x7F, 0xD5, 0xE8, 0x51, 0x41, 0x12, 0x00, 0x00
	.byte 0x5D, 0x6F, 0xAD, 0xDD, 0x75, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x42, 0xAD, 0xFF, 0xDA, 0x08, 0x00, 0x55, 0x10, 0x00
	.byte 0xEB, 0xDA, 0xFA, 0xAB, 0xAC, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x05, 0x7F, 0x7F, 0xE8, 0x00, 0x05, 0x44, 0x40, 0x00
	.byte 0x5E, 0xB7, 0x56, 0xDD, 0x7A, 0x80, 0x00, 0x10, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xAF, 0xEE, 0xBD, 0x00, 0x00, 0x29, 0x00, 0x00
	.byte 0xAB, 0x6A, 0xEB, 0x6B, 0x56, 0x00, 0x00, 0x04, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0D, 0x7D, 0xBB, 0xE4, 0x00, 0x0A, 0x94, 0x80, 0x00
	.byte 0x56, 0xDB, 0x5A, 0xAD, 0xBD, 0xC0, 0x00, 0x01, 0x00, 0x08, 0x08, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x37, 0xFF, 0xBC, 0x84, 0x25, 0x4A, 0x20, 0x00
	.byte 0xAA, 0xAD, 0xAA, 0xAA, 0xD6, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0xDF, 0x75, 0xD0, 0x00, 0x09, 0x32, 0x80, 0x00
	.byte 0x2A, 0xAA, 0xAA, 0xB5, 0xAD, 0xD0, 0x00, 0x00, 0x00, 0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x04, 0x40, 0xBB, 0xFF, 0x6A, 0x00, 0x92, 0x44, 0x10, 0x00
	.byte 0x45, 0x55, 0x2A, 0xAD, 0x76, 0x48, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x5E, 0xD5, 0x90, 0x00, 0x09, 0x2A, 0x80, 0x00
	.byte 0x14, 0x49, 0x52, 0x92, 0xAD, 0xB4, 0x00, 0x00, 0x00, 0x01, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x2F, 0xFA, 0xA8, 0x00, 0x12, 0x54, 0x00, 0x00
	.byte 0x42, 0xA6, 0xAA, 0x4A, 0xDA, 0x80, 0x00, 0x10, 0x0A, 0xA2, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xB5, 0xAC, 0x00, 0x00, 0x24, 0x92, 0x90, 0x00
	.byte 0x08, 0x10, 0x00, 0xAA, 0xAA, 0xA8, 0x00, 0x00, 0x00, 0x0A, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0E, 0xE5, 0x48, 0x01, 0x12, 0x4A, 0x00, 0x00
	.byte 0x02, 0x4A, 0xA9, 0x09, 0x55, 0x50, 0x00, 0x01, 0x05, 0x40, 0x88, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x13, 0x48, 0x00, 0x04, 0x44, 0x90, 0x80, 0x00
	.byte 0x00, 0x00, 0x04, 0x22, 0xAA, 0xAA, 0x80, 0x00, 0x12, 0xB2, 0x60, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4C, 0xA1, 0x00, 0x00, 0x09, 0x2D, 0x00, 0x00
	.byte 0x08, 0x89, 0x41, 0x48, 0xAA, 0x40, 0x00, 0x00, 0x05, 0x41, 0x28, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x02, 0x40, 0x20, 0x00
	.byte 0x00, 0x20, 0x12, 0x05, 0x12, 0x94, 0x00, 0x00, 0x1D, 0xB9, 0x00, 0x40, 0x00, 0x00, 0x40, 0x00, 0x00, 0x14, 0x20, 0x00, 0x10, 0x28, 0x94, 0x80, 0x00
	.byte 0x00, 0x02, 0x00, 0x20, 0xA9, 0x41, 0x00, 0x00, 0x57, 0x44, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x49, 0x00, 0x00
	.byte 0x00, 0x08, 0x92, 0x89, 0x04, 0x14, 0x00, 0x00, 0x1D, 0x5A, 0x41, 0x40, 0x0A, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x13, 0x55, 0x24, 0x20, 0x00
	.byte 0x02, 0x00, 0x00, 0x02, 0x51, 0x40, 0x00, 0x00, 0x37, 0xA0, 0x82, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD0, 0x91, 0x00, 0x00
	.byte 0x00, 0x24, 0x90, 0x20, 0x04, 0x08, 0x80, 0x00, 0x1E, 0xA8, 0x0A, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x05, 0x24, 0x00, 0x00
	.byte 0x00, 0x00, 0x04, 0x09, 0x41, 0x00, 0x00, 0x80, 0x37, 0xA1, 0x1A, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x1D, 0x48, 0x92, 0x40, 0x00
	.byte 0x00, 0x02, 0x41, 0x00, 0x08, 0x20, 0x00, 0x00, 0x1B, 0x50, 0x2A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x52, 0x48, 0x00, 0x00
	.byte 0x10, 0x80, 0x08, 0x40, 0x00, 0x00, 0x00, 0x00, 0x2E, 0xA0, 0x34, 0x80, 0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x95, 0x2A, 0x80, 0x00
	.byte 0x00, 0x08, 0x20, 0x04, 0x42, 0x00, 0x20, 0x00, 0x1A, 0x90, 0xAA, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x04, 0x20, 0x40, 0x00, 0x00
	.byte 0x04, 0x21, 0x01, 0x00, 0x00, 0x02, 0x00, 0x00, 0x14, 0x40, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x95, 0x29, 0x00, 0x00
	.byte 0x00, 0x00, 0x08, 0x10, 0x00, 0x10, 0x84, 0x00, 0x0A, 0xA9, 0x3A, 0x02, 0x08, 0x00, 0x04, 0xC0, 0x00, 0x80, 0x00, 0x00, 0x02, 0x00, 0xA4, 0x20, 0x00
	.byte 0x00, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1A, 0xA0, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x09, 0x00, 0x00
	.byte 0x00, 0x00, 0x41, 0x01, 0x00, 0x04, 0x20, 0x00, 0x0F, 0x49, 0x6D, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x04, 0x00, 0x00, 0x08, 0x00, 0x54, 0x00, 0x00
	.byte 0x08, 0x10, 0x04, 0x08, 0x10, 0x21, 0x00, 0x00, 0x36, 0xA0, 0x5A, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x95, 0x01, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x08, 0x00, 0x2D, 0x92, 0xB5, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x54, 0x00, 0x00
	.byte 0x00, 0x80, 0x10, 0x00, 0x00, 0x92, 0x40, 0x00, 0x35, 0x40, 0xAD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x52, 0x00, 0x20, 0x00
	.byte 0x00, 0x04, 0x80, 0x08, 0x84, 0x00, 0x00, 0x00, 0x57, 0x6A, 0xB7, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x55, 0x00, 0x00
	.byte 0x00, 0x00, 0x02, 0x40, 0x00, 0x00, 0x00, 0x00, 0x1A, 0x80, 0x5A, 0x84, 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x2C, 0x48, 0x80, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x24, 0x80, 0x00, 0x27, 0x42, 0xAE, 0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x14, 0x80, 0x00
	.byte 0x00, 0x00, 0x20, 0x09, 0x10, 0x00, 0x00, 0x00, 0x1C, 0xA8, 0x0B, 0x40, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x74, 0x88, 0x80, 0x00, 0x00
	.byte 0x00, 0x00, 0x04, 0x80, 0x00, 0x00, 0x00, 0x00, 0x47, 0x80, 0x36, 0xA0, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x00, 0x12, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x20, 0x02, 0x40, 0x00, 0x00, 0x1D, 0x52, 0x4B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x70, 0x51, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x09, 0x10, 0x08, 0x00, 0x00, 0x06, 0x80, 0x16, 0xC0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xED, 0x02, 0xA9, 0x00, 0x00
	.byte 0x00, 0x00, 0x92, 0x80, 0x00, 0x00, 0x00, 0x00, 0x2D, 0x40, 0x95, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x12, 0x42, 0x40, 0x00, 0x00, 0x86, 0xA0, 0x2B, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x78, 0x49, 0x08, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0B, 0x48, 0x2A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0xEA, 0x00, 0x40, 0x80, 0x00
	.byte 0x00, 0x00, 0x01, 0x24, 0xA0, 0x10, 0x00, 0x00, 0x46, 0xA2, 0x57, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x82, 0x04, 0x00, 0x00
	.byte 0x00, 0x00, 0x24, 0x00, 0x00, 0x80, 0x00, 0x00, 0x15, 0x4C, 0xAA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x62, 0x08, 0x90, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x12, 0x14, 0x00, 0x00, 0x00, 0x43, 0xA1, 0x16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x20, 0x02, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x80, 0x41, 0x04, 0x00, 0x22, 0x85, 0x52, 0xAC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x02, 0x10, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x09, 0x08, 0x00, 0x00, 0x00, 0x23, 0x48, 0x5A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x48, 0x80, 0x00, 0x00
	.byte 0x00, 0x00, 0x04, 0x00, 0x42, 0x40, 0x00, 0x04, 0x85, 0xA0, 0x14, 0x00, 0x81, 0x00, 0x80, 0x00, 0x04, 0x00, 0x00, 0x00, 0x14, 0x00, 0x21, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x40, 0x08, 0x10, 0x00, 0x92, 0xA3, 0x54, 0x5C, 0x00, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x24, 0x08, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x04, 0x82, 0x00, 0x02, 0x25, 0x46, 0xC5, 0x50, 0x00, 0xA9, 0x20, 0x00, 0x00, 0x92, 0x80, 0x00, 0x00, 0x30, 0x80, 0x80, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x20, 0x42, 0x00, 0x4A, 0xD1, 0x28, 0xB8, 0x00, 0xA2, 0x40, 0x82, 0x24, 0x04, 0x00, 0x00, 0x00, 0x0A, 0x02, 0x22, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x20, 0x04, 0x00, 0x10, 0x55, 0x61, 0xD5, 0x50, 0x04, 0x94, 0xA8, 0x00, 0x40, 0x21, 0x40, 0x00, 0x00, 0x04, 0x90, 0x00, 0x00, 0x00
	.byte 0x00, 0x80, 0x00, 0x04, 0x91, 0x08, 0x85, 0x15, 0xB0, 0x08, 0xB0, 0x01, 0x52, 0x02, 0x40, 0x0A, 0x8A, 0x80, 0x00, 0x00, 0x0A, 0x08, 0x90, 0x00, 0x00
	.byte 0x00, 0x08, 0x00, 0x00, 0x00, 0x40, 0x20, 0xAB, 0x68, 0x6B, 0x60, 0x04, 0xA9, 0x50, 0x0A, 0x40, 0x20, 0x50, 0x00, 0x00, 0x09, 0x40, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x80, 0x24, 0x04, 0x8A, 0x56, 0xBC, 0x0A, 0xA0, 0x01, 0x02, 0x01, 0x20, 0x04, 0x8A, 0x84, 0x00, 0x20, 0x04, 0x05, 0x04, 0x80, 0x00
	.byte 0x00, 0x00, 0x00, 0x08, 0x01, 0x00, 0x21, 0x55, 0xE8, 0x12, 0xC0, 0x04, 0xA8, 0x84, 0x09, 0x00, 0x20, 0x20, 0x00, 0x00, 0x01, 0x20, 0x10, 0x00, 0x00
	.byte 0x00, 0x00, 0x40, 0x01, 0x00, 0x52, 0x8A, 0x2B, 0x5C, 0x0B, 0x60, 0x05, 0x02, 0x50, 0x00, 0x21, 0x02, 0x84, 0x00, 0x00, 0x04, 0x82, 0x40, 0x00, 0x00
	.byte 0x02, 0x00, 0x00, 0x20, 0x24, 0x00, 0x21, 0x56, 0xF6, 0x05, 0x80, 0x15, 0x50, 0x01, 0x20, 0x04, 0x50, 0x20, 0x80, 0x00, 0x04, 0x10, 0x00, 0x00, 0x00
	.byte 0x00, 0x10, 0x02, 0x00, 0x00, 0x04, 0x8A, 0xAA, 0xAE, 0x02, 0xC0, 0x05, 0x01, 0x08, 0x00, 0x00, 0x04, 0x90, 0x00, 0x00, 0x00, 0x80, 0x10, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x01, 0x01, 0x20, 0x20, 0x2B, 0x7B, 0x01, 0x00, 0x12, 0x94, 0x40, 0x04, 0x90, 0x80, 0x05, 0x00, 0x00, 0x04, 0x24, 0x82, 0x00, 0x00
	.byte 0x00, 0x01, 0x00, 0x48, 0x10, 0x02, 0x02, 0xA5, 0x4D, 0x81, 0x00, 0x04, 0x40, 0x04, 0x40, 0x00, 0x01, 0x20, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x48, 0x16, 0xFB, 0x00, 0x00, 0x12, 0x10, 0x80, 0x00, 0x04, 0x10, 0x0A, 0x48, 0x00, 0x02, 0x80, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x12, 0x00, 0x40, 0x08, 0x00, 0x21, 0x56, 0xE0, 0x00, 0x00, 0x4A, 0x20, 0x08, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x24, 0x84, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x04, 0x00, 0x01, 0x01, 0x0A, 0xAB, 0x40, 0x00, 0x45, 0x00, 0x04, 0x81, 0x20, 0x05, 0x20, 0x00, 0x00, 0x02, 0x00, 0x10, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x10, 0x00, 0xAA, 0xA0, 0x00, 0x10, 0x22, 0x80, 0x00, 0x00, 0x00, 0x04, 0xA4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2A, 0x15, 0x50, 0x00, 0x04, 0x88, 0x20, 0x00, 0x09, 0x20, 0x00, 0x00, 0x00, 0x00, 0x24, 0x40, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA2, 0x00, 0x90, 0x40, 0x88, 0x09, 0x00, 0x02, 0x20, 0x00, 0x80, 0x02, 0x00, 0x09, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x08, 0x00, 0x02, 0x08, 0x01, 0x00, 0x20, 0x00, 0x04, 0x92, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4A, 0x15, 0x20, 0x00, 0x88, 0x22, 0x40, 0x20, 0x02, 0x20, 0x00, 0x00, 0x00, 0x08, 0x40, 0x00, 0x00, 0x00
	.byte 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x49, 0x42, 0x00, 0x00, 0x08, 0x04, 0x90, 0x02, 0x20, 0x00, 0x10, 0x00, 0x09, 0x22, 0x00, 0x00
	.byte 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x02, 0x05, 0x00, 0x08, 0x24, 0x90, 0x82, 0x00, 0x00, 0x00, 0x04, 0x92, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x88, 0xA0, 0x00, 0x00, 0x00, 0x04, 0x20, 0x40, 0x00, 0x88, 0x00, 0x00, 0x42, 0x04, 0x80, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x08, 0x91, 0x21, 0x00, 0x00, 0x00, 0x12, 0x48, 0x00, 0x90, 0x00, 0x00, 0x20, 0x08, 0x48, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x82, 0x00, 0x04, 0x24, 0xA9, 0x49, 0x00, 0x00, 0x00, 0x02, 0x49, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x48, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
