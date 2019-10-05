# ogg Makefile for targetting Nintendo64

CFLAGS = -std=gnu99 -O3 -G0 -Wall -mtune=vr4300 -march=vr4300 -I$(N64_INST)/include -I$(N64_INST)/mips64-elf/include
CFLAGS+= -Iinclude/
ASFLAGS = -mtune=vr4300 -march=vr4300
N64PREFIX = $(N64_INST)/bin/mips64-elf-
INSTALLDIR = $(N64_INST)
CC = $(N64PREFIX)gcc
AS = $(N64PREFIX)as
LD = $(N64PREFIX)ld
AR = $(N64PREFIX)ar

all: libogg.a

SRCS = src/bitwise.c src/framing.c

OBJS = $(SRCS:.c=.o)

libogg.a: $(OBJS)
	$(AR) -rcs -o $@ $(OBJS)


install: all
	install -D --mode=644 libogg.a $(INSTALLDIR)/lib/libogg.a
	install -D --mode=644 include/ogg/ogg.h $(INSTALLDIR)/include/ogg/ogg.h
	install -D --mode=644 include/ogg/os_types.h $(INSTALLDIR)/include/ogg/os_types.h
	install -D --mode=644 include/ogg/config_types.h $(INSTALLDIR)/include/ogg/config_types.h

.PHONY: clean
clean:
	rm -f $(OBJS) *.a

