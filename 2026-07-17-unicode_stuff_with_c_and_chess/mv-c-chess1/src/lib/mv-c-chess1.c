#include "mv-c-chess1.h"
#include <locale.h>


void mv_c_chess1_hello()
{
	setlocale(LC_ALL, "");
	wprintf(L"Hello, from mv_c_chess 2.\n");
	print_chess_board(chess_board);
	wprintf(L"After.\n");
}

void print_chess_board( wchar_t board[][CHESS_BOARD_COLS])
{
//wprintf(L"\x1b[48;5;196mRed Background Wide String\x1b[0m\n");
	wprintf(L"Printing...\n");
	for (int i = 0; i < 8; i++) {
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

