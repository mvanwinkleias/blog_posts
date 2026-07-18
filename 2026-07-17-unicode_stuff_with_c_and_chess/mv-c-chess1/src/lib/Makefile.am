# These might be a good idea
.POSIX:
AM_CFLAGS = -std=c99 -pedantic -D_POSIX_C_SOURCE=200809L -Wall -Wextra
AM_LDFLAGS = 

# This might be how to add CPP stuff
# AM_CPPFLAGS =  -pedantic -Wall -Wextra
# AM_CPPFLAGS+= -std=c++11

# This might be how to link against things:
# AM_CFLAGS += -lmv-c-chess1
# AM_LDFLAGS += -lsome_library


# === Libraries ===
# Libraries that are generated and to be installed by this:
pkgconfigdir = ${libdir}/pkgconfig
pkgconfig_DATA = mv-c-chess1.pc

lib_LTLIBRARIES = libmv-c-chess1.la

libmv_c_chess1_la_SOURCES = \
	mv-c-chess1.c \
	mv-c-chess1.h \
	mv-c-chess1.map 


include_HEADERS = \
	mv-c-chess1.h 

# If we don't initialize this, we can't use += later, so
# we just assume this is the only place where this variable is initailzed.
libmv_c_chess1_la_LDFLAGS = ''
# You can use ```objdump -T``` to check the version info of the symbols of the resulting
# .so file(s)

# This is how to use ldd version scripts for the ABI.
# See
# * https://www.gnu.org/software/gnulib/manual/html_node/LD-Version-Scripts.html
libmv_c_chess1_la_LDFLAGS += -Wl,--version-script=$(srcdir)/mv-c-chess1.map



# === End Libraries ===
