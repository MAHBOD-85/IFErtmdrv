# IFErtmdrv
A super compact NES sound driver designed for feature richness

# How to use
Consult the manual txt file and the provided demos for song production.

To use the driver in your game simply include IFErtmdrv in your NES game to be called each frame, clear the memory, initialize the sweep unit to be disabled and load the songAddr variable to be the location of your song in $XX00. You can also detect region and load it into the Region variable.

For version Z also do the zsaw initialization procedure outlined in [the z-saw repo](https://github.com/zeta0134/z-saw).
