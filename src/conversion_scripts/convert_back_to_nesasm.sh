#!/bin/bash

sed -i 's/\.segment "BSS"/.org $710/g' variables.asm
sed -i 's/\.segment "ZEROPAGE"/.org $F0/g' variables.asm
sed -i 's/\.res/.ds/g' variables.asm
sed -i -e 's/(/[/g' *.asm
sed -i -e 's/)/]/g' *.asm
