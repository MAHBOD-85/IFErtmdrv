#!/bin/sh
ca65 mainz.asm -o mainz.o -g && ld65 -o mainz.nes -C main.cfg mainz.o --dbgfile mainz.dbg && Mesen mainz.nes
