# .POSIX might be a good idea.
.POSIX:
AM_CFLAGS = -std=c99 -pedantic -D_POSIX_C_SOURCE=200809L -Wall -Wextra -I$(top_srcdir)/src/lib
AM_LDFLAGS = -L../src/lib

# This might be how to add CPP stuff
# AM_CPPFLAGS =  -pedantic -Wall -Wextra
# AM_CPPFLAGS+= -std=c++11

# This might be how to link against a library in this project which might
# not be available with pkgconfig yet.
AM_CFLAGS += -lmv-c-chess1
# AM_LDFLAGS += -lsome_library

# AM_CFLAGS += -pthread
# AM_LDFLAGS += -lpthread

# === Programs ===

check_PROGRAMS = check_mv-c-chess1 
check_mv_c_chess1_SOURCES = \
	test_mv-c-chess1.c
TESTS = $(check_PROGRAMS)

# Needed, as per:
# https://www.gnu.org/software/automake/manual/html_node/Objects-created-both-with-libtool-and-without.html
check_mv_c_chess1_CFLAGS = $(AM_CFLAGS)
check_mv_c_chess1_LDFLAGS = $(AM_LDFLAGS)

# === End Programs ===

