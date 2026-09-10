#!/bin/sh
ca65 main.asm -o main.o -g && ld65 -o main.nes -C main.cfg main.o --dbgfile main.dbg && Mesen main.nes
