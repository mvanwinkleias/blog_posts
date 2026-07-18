#ifndef mv_c_chess1_piece_movement
#define mv_c_chess1_piece_movement

#include "mv-c-chess1.h"

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


short int is_valid_move_rook(
	chess_state * game,
	chess_piece * piece
);

short int is_valid_move_queen(
	chess_state * game,
	chess_piece * piece
);

short int is_valid_move_king(
	chess_state * game,
	chess_piece * piece
);

#endif // mv_c_chess1_piece_movement
