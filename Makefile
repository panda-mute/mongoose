CC ?= gcc

PROG=mongoose_httpd

SRCS = httpd.c mongoose.c
#CFLAGS = -g -W -Wall -Werror -Wno-unused-function -DMG_ENABLE_HTTP -DMG_ENABLE_HTTP_CGI -DMG_ENABLE_SSL
CFLAGS = -g -W -Wall -Wno-unused-function -DMG_ENABLE_HTTP -DMG_ENABLE_HTTP_CGI -DMG_ENABLE_SSL


CFLAGS += -pthread
SSL_LIB=openssl

ifeq ($(SSL_LIB),openssl)
CFLAGS += -DMG_ENABLE_SSL -lssl -lcrypto
endif
ifeq ($(SSL_LIB), krypton)
CFLAGS += -DMG_ENABLE_SSL ../../../krypton/krypton.c -I../../../krypton
endif
ifeq ($(SSL_LIB),mbedtls)
CFLAGS += -DMG_ENABLE_SSL -DMG_SSL_IF=MG_SSL_IF_MBEDTLS -DMG_SSL_MBED_DUMMY_RANDOM -lmbedcrypto -lmbedtls -lmbedx509
endif

all: $(PROG)

$(PROG): $(SRCS)
	$(CC) $(SRCS) -o $@ $(CFLAGS)

clean:
	rm -rf *.o $(PROG)
