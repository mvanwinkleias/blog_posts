#ifndef mv_c_chess1__
#define mv_c_chess1__

#include <stdio.h>
#include <wchar.h>
#include <locale.h>

#define CHESS_BOARD_ROWS 8
#define CHESS_BOARD_COLS 8

extern void mv_c_chess1_hello(void);
extern void print_chess_board( wchar_t board[][CHESS_BOARD_COLS]);

wchar_t chess_board[CHESS_BOARD_ROWS][CHESS_BOARD_COLS] = {
	L"♜♞♝♛♚♝♞♜",
	L"♟♟♟♟♟♟♟♟",
	L"        ",
	L"        ",
	L"        ",
	L"        ",
	L"♙♙♙♙♙♙♙♙",
	L"♖♘♗♕♔♗♘♖",
};



#endif // mv_c_chess1__

// Compile this with:
//
// gcc -c -Wall -Werror -fpic hello_ias.c
// gcc -shared -o libhello_ias.so hello_ias.o
