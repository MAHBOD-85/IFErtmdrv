#!/bin/bash

sed -i 's/\.org $710/.section "IFERTMDRVVARS"/g' variables.asm
sed -i 's/\.org $F0/.section "IFERTMDRVZP"/g' variables.asm
sed -i 's/\.ds/.res/g' variables.asm
sed -i 's/\[/(/g' *.asm
sed -i 's/\]/)/g' *.asm
