#!/bin/bash

sed -i 's/\.section "IFERTMDRVVARS"/.org $710/g' variables.asm
sed -i 's/\.section "IFERTMDRVZP"/.org $F0/g' variables.asm
sed -i 's/\.res/.ds/g' variables.asm
sed -i -e 's/(/[/g' *.asm
sed -i -e 's/)/]/g' *.asm
