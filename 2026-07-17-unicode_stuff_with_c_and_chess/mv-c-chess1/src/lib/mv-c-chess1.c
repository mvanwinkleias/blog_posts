#include "mv-c-chess1.h"
#include <locale.h>

short int is_valid_move_pawn(
	chess_state * game,
	chess_piece * piece
)
{
	return 1;
}


short int is_valid_move_knight(
	chess_state * game,
	chess_piece * piece
)
{
	return 1;
}

short int is_valid_move_bishop(
	chess_state * game,
	chess_piece * piece
)
{
	return 1;
}


short int is_valid_move_rook(
	chess_state * game,
	chess_piece * piece
)
{
	return 1;
}

short int is_valid_move_queen(
	chess_state * game,
	chess_piece * piece
)
{
	return 1;
}

short int is_valid_move_king(
	chess_state * game,
	chess_piece * piece
)
{
	return 1;
}
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

void mv_c_chess1_hello()
{
	setlocale(LC_ALL, "");
	wprintf(L"Hello, from mv_c_chess.\n");
	print_chess_board(chess_board);
}

void print_chess_board( wchar_t board[][CHESS_BOARD_COLS])
{
//wprintf(L"\x1b[48;5;196mRed Background Wide String\x1b[0m\n");
	wprintf(L"   a  b  c  d  e  f  g  h\n");
	for (int i = 0; i < 8; i++) {
		wprintf(L"%d ", 8-i);
		for (int j = 0; j < 8; j++)
		{
			if (j % 2 != i % 2)
			{
				wprintf(L"\x1b[40m");
			}
			else
			{
				wprintf(L"\x1b[47m");
			}
			wprintf(L" %lc ", board[i][j]);
		}
		wprintf(L"\x1b[0m");
		wprintf(L"\n");
	}

}

