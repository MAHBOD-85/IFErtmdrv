# IFErtmdrv
A super compact NES sound driver designed for feature richness

## How to use
Consult the manual txt file and the provided demos for song production (demo songs in new format coming soon).

To use the driver in your game simply include IFErtmdrv in your NES game to be called each frame and the variables in the beginning of your main asm file, clear the driver's memory, initialize the sweep unit to be disabled and load the songAddr variable to be the high byte location of your song (should be enough if your song is aligned to a page) and songAddrProgress with the low byte of the song address if need be. You can also detect region and load it into the Region variable.

For version Z also do the zsaw initialization procedure outlined in [the z-saw repo](https://github.com/zeta0134/z-saw).

### nesasm porting
Execute the conversion script provided in the ifertmdrv folder. You might need to do additional setup.
