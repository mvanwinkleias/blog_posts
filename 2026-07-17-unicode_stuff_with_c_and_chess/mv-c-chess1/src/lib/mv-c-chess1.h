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

enum Player_Colors {
	Player_White,
	Player_Black,
};

enum Chess_Pieces {
	Piece_Pawn,
	Piece_Knight,
	Piece_Bishop,
	Piece_Rook,
	Piece_Queen,
	Piece_King,
};

	
typedef struct chess_piece {
	short int value;
	short int row;
	short int col;
	short int color;
	short int is_alive;
	short int * is_valid_move;
} chess_piece;

typedef chess_piece * chess_state[32];

short int is_valid_move_pawn(
	chess_state * game,
	chess_piece * piece
);


short int is_valid_move_knight(
	chess_state * game,
	chess_piece * piece
);

short int is_valid_move_bishop(
	chess_state * game,
	chess_piece * piece
);


#endif // mv_c_chess1__

// Compile this with:
//
// gcc -c -Wall -Werror -fpic hello_ias.c
// gcc -shared -o libhello_ias.so hello_ias.o
