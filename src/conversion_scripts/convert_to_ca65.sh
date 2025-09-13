#!/bin/bash

sed -i 's/\.org $710/.segment "BSS"/g' variables.asm
sed -i 's/\.org $F0/.segment "ZEROPAGE"/g' variables.asm
sed -i 's/\.ds/.res/g' variables.asm
sed -i 's/\[/(/g' *.asm
sed -i 's/\]/)/g' *.asm
