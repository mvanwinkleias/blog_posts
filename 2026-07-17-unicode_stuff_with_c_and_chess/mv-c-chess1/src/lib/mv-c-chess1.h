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

typedef struct chess_piece_type {
	enum Chess_Pieces type;
	short int value;
	short int * move_checker;
} chess_piece_type;


typedef struct chess_piece {
	chess_piece_type type;
	short int row;
	short int col;
	enum Player_Colors color;
	short int is_alive;
	short int * is_valid_move;
} chess_piece;

typedef chess_piece * chess_state[32];


#include "mv-chess-piece-movement.c"

chess_piece_type chess_piece_type_pawn = {
	Piece_Pawn,
	1,
	*is_valid_move_pawn
};

chess_piece_type chess_piece_type_knight = {
	Piece_Knight,
	3
};

chess_piece_type chess_peice_type_bishop = {
	Piece_Bishop,
	3
};

chess_piece_type chess_peice_type_rook = {
	Piece_Rook,
	5
};

chess_piece_type chess_piece_type_queen = {
	Piece_Queen,
	9
};

chess_piece_type chess_piece_type_king = {
	Piece_King,
	0,
};

#endif // mv_c_chess1__

// Compile this with:
//
// gcc -c -Wall -Werror -fpic hello_ias.c
// gcc -shared -o libhello_ias.so hello_ias.o
