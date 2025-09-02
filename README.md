# IFErtmdrv
A super compact NES sound driver designed for feature richness

## How to use
Consult the manual txt file and the provided demos for song production.

To use the driver in your game simply include IFErtmdrv in your NES game to be called each frame and the variables in the beginning of your main asm file, clear the memory, initialize the sweep unit to be disabled and load the songAddr variable to be the location of your song in $XX00. You can also detect region and load it into the Region variable.

For version Z also do the zsaw initialization procedure outlined in [the z-saw repo](https://github.com/zeta0134/z-saw).

### ca65 porting
Just replace all instances of [] with () and change the .org thing in the beginning of variables.asm to a segment and change .ds to .res. To reference the values in the driver you may need to manually specify the zeropage values which ld65 conveniently warns you about. 
