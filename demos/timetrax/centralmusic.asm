lead25 = 0
lead25c = 2
arpmaj = 6
arpmin = 17
hihat = 25
arpmaj4 = 29
guit50 = 32
lead50 = 36
guit12 = 38
lead12 = 42
kick = 44
snare = 51
slideup = 58
slidedown = 63
slidedown2 = 68
bass = 72
tridrum = 76
lead254 = 80
arp12 = 82
ohihat = 84
vibrato = 97
vibrato2 = 110
lead50vibrato = 123
lead50vibrato2 = 126
buzz = 129
buzzchug = 137
hiride = 143
loride = 148
bell = 154

t4beat = $06
thbeat = $05
t1beat = $04
t1hbeat = $0B
tinst = $08
tinst2 = $09
tinst3 = $0A

mc_songstart:
  .byte PAT_INFO, $3F, $00
  .byte INSTBANK_SET
  .word instrument

  .byte >mc_pattern3,<mc_pattern3
  .byte >mc_pattern2,<mc_pattern2
  .byte >mc_pattern4,<mc_pattern4
  .byte >mc_pattern1,<mc_pattern1

mc_songloop:
  .byte PAT_INFO, $7F, $00

  .byte >mc_pattern7,<mc_pattern7
  .byte >mc_pattern5,<mc_pattern5
  .byte >mc_pattern8,<mc_pattern8
  .byte >mc_pattern1,<mc_pattern1

  .byte 0
  .byte >mc_pattern6,<mc_pattern6
  .byte 0
  .byte 0

  .byte >mc_pattern9,<mc_pattern9
  .byte >mc_pattern10,<mc_pattern10
  .byte >mc_pattern11,<mc_pattern11
  .byte >mc_pattern12,<mc_pattern12

  .byte 0
  .byte 0
  .byte 0
  .byte 0

  .byte >mc_pattern13,<mc_pattern13
  .byte 0
  .byte 0
  .byte 0

  .byte >mc_pattern14,<mc_pattern14
  .byte 0
  .byte 0
  .byte 0

  .byte >mc_pattern17,<mc_pattern17
  .byte >mc_pattern18,<mc_pattern18
  .byte >mc_pattern15,<mc_pattern15
  .byte 0

  .byte >mc_pattern19,<mc_pattern19
  .byte >mc_pattern20,<mc_pattern20
  .byte >mc_pattern16,<mc_pattern16
  .byte 0

  .byte >mc_pattern21,<mc_pattern21
  .byte >mc_pattern18,<mc_pattern18
  .byte >mc_pattern15,<mc_pattern15
  .byte 0

  .byte 0
  .byte >mc_pattern20,<mc_pattern20
  .byte >mc_pattern16,<mc_pattern16
  .byte 0

  .byte PAT_INFO, $FF, $00

  .byte 0
  .byte >mc_pattern10,<mc_pattern10
  .byte >mc_pattern4,<mc_pattern4
  .byte >mc_pattern22,<mc_pattern22

  .byte >mc_pattern25,<mc_pattern25
  .byte 0
  .byte >mc_pattern24,<mc_pattern24
  .byte >mc_pattern23,<mc_pattern23

  .byte 0
  .byte 0
  .byte 0
  .byte 0

  .byte PAT_JUMP
  .word mc_songloop

mc_pattern0:
mc_pattern0loop:
  .byte OFF
  .byte JUMP, <(mc_pattern0loop-*)


mc_pattern1:
  .byte INST2, hihat
  .byte EFF_DIVISOR, $01
mc_pattern1loop:
  .byte N3+1
  .byte EFF_MINILOOP, 110, <(mc_pattern1loop-*)
mc_pattern1loop2:
  .byte INST1, kick
  .byte N7, N3+1, N3+1, N3+1
  .byte EFF_MINILOOP, 112, <(mc_pattern1loop2-*)
  .byte N7, N3+1
  .byte INST1, $FF
  .byte N7, snare, N7, snare

mc_pattern2:
  .byte INST1, arpmaj
  .byte INST2, arpmaj4
  .byte AS2, DELAY3, t4beat
mc_pattern2loop:
  .byte AS2, DELAY3, thbeat, AS2+1, I
  .byte EFF_MINILOOP, $00, <(mc_pattern2loop-*)
  .byte AS2, I, AS2+1, EFF_MINILOOPFLAG, $00, I
  .byte JUMP, <(mc_pattern2loop-*)

mc_pattern3:
  .byte INST2, lead25c
mc_pattern3loop:
  .byte D3+1, E3+1, F3+1, G3+1, A3+1, AS3+1, C4+1, D4+1
  .byte JUMP, <(mc_pattern3loop-*)

mc_pattern4:
  .byte INST1, lead25
  .byte EFF_DIVISOR, $01
mc_pattern4loop:
  .byte G2
  .byte EFF_MINILOOP, 62, <(mc_pattern4loop-*)
mc_pattern4loop2:
  .byte G3
  .byte JUMP, <(mc_pattern4loop2-*)

mc_pattern5:
  .byte INST1, lead25
  .byte INST2, arpmaj
mc_pattern5loop:
  .byte D4, AS2+1, C4, AS2+1, E4, AS2+1, F4, AS2+1, G4, AS2+1, E4, AS2+1, C4, AS2+1, A3, AS2+1
  .byte EFF_MINILOOP, $02, <(mc_pattern5loop-*)
  .byte EFF_MINILOOPFLAG, $00, INST2, arpmin, JUMP, <(mc_pattern5loop-*)

mc_pattern6:
  .byte INST1, lead50
  .byte INST2, arpmaj
mc_pattern6loop:
  .byte C3, AS2+1, D3, AS2+1, D3, AS2+1, F3, AS2+1
  .byte EFF_MINILOOP, $06, <(mc_pattern6loop-*)
  .byte EFF_MINILOOPFLAG, $00, INST2, arpmin, JUMP, <(mc_pattern6loop-*)

mc_pattern7:
  .byte INST1, $FF
  .byte INST2, lead25
  .byte EFF_DIVISOR, $FF
  .byte G2, slideup, $03, G3+1, $03, G3+1, $17, G3, slidedown, $03, G2+1, $03, G2+1, $17, G3, slideup, $03, G4+1, $03, G4+1, $17, G4, slidedown2, $03, G2+1, $03, G2+1, $17
  .byte D3, slideup, $03, D4+1, $03, D4+1, $17, F4+1, $7, F4+1, $17, F3, slideup, $03, F4+1, $03, F4+1, $17, G4+1, $7, G4+1, $17

mc_pattern8:
  .byte INST1, bass
  .byte INST2, tridrum
mc_pattern8loop:
  .byte G2, G3, G2, G2, D3, D2, F3, C4
  .byte EFF_MINILOOP, 12, <(mc_pattern8loop-*)
  .byte A3+1, G3, G2, G2, A3+1, D2, F3, C4
  .byte A3+1, G3, G2, G2, A3+1, D2, CS4+1, CS4+1

mc_pattern10:
  .byte INST1, arp12
mc_pattern10loop:
  .byte AS2, D3, F3, G3
  .byte JUMP, <(mc_pattern10loop-*)

mc_pattern24:
  .byte INST1, bass
mc_pattern24loop2:
  .byte F2, G2, G2, G2, AS2, AS2, C3
  .byte EFF_MINILOOP, 14, <(mc_pattern24loop-*)
  .byte EFF_MINILOOPFLAG, 0
  .byte CS4+1
  .byte JUMP, <(mc_pattern11-*)
mc_pattern24loop:
  .byte C3
  .byte JUMP, <(mc_pattern24loop2-*)

mc_pattern11:
  .byte A3+1, G2, G2, G2, CS4+1, AS2, C3
  .byte EFF_MINILOOP, 2, <(mc_pattern11loop-*)
  .byte EFF_MINILOOPFLAG, 0
  .byte CS4+1
  .byte JUMP, <(mc_pattern11-*)
mc_pattern11loop:
  .byte C3
  .byte JUMP, <(mc_pattern11-*)

mc_pattern15:
  .byte A3+1, DS2, DS3, DS3, CS4+1, AS2, DS3
  .byte EFF_MINILOOP, 2, <(mc_pattern15loop-*)
  .byte EFF_MINILOOPFLAG, 0
  .byte CS4+1
  .byte JUMP, <(mc_pattern15-*)
mc_pattern15loop:
  .byte DS3
  .byte JUMP, <(mc_pattern15-*)

mc_pattern16:
  .byte A3+1, D2, D3, D3, CS4+1, A2, C3
  .byte EFF_MINILOOP, 2, <(mc_pattern16loop-*)
  .byte EFF_MINILOOPFLAG, 0
  .byte CS4+1
  .byte JUMP, <(mc_pattern16-*)
mc_pattern16loop:
  .byte C3
  .byte JUMP, <(mc_pattern16-*)

mc_pattern12:
  .byte N7, kick, N3+1, N4, ohihat, N3+1, N7, snare, N3+1, N4, ohihat
  .byte EFF_MINILOOP, 2, <(mc_pattern12loop-*)
  .byte EFF_MINILOOPFLAG, 0
  .byte N7, snare
  .byte JUMP, <(mc_pattern12-*)
mc_pattern12loop:
  .byte N3+1
  .byte JUMP, <(mc_pattern12-*)

mc_pattern23:
  .byte INST2, hiride
  .byte NA, buzzchug, NA, buzzchug, NA, buzz, I, I, DELAY3, thbeat
mc_pattern23loop:
  .byte PN1+1, PN1+1, PN1, loride, I, EFF_MINILOOP, $0C, <(mc_pattern23loop-*)
mc_pattern23loop2:
  .byte PN1+1, PN1+1, PN1, loride, PN1+1, EFF_MINILOOP, $1A, <(mc_pattern23loop2-*)
  .byte PN1+1, PN1+1, PN1, loride, EFF_MINILOOPFLAG, $00, N7, snare
  .byte INST2, hihat
  .byte JUMP, <(mc_pattern12-*)

mc_pattern21:
  .byte EFF_DIVISOR, $01
mc_pattern21loop:
  .byte F3+1, G3, AS3+1, C4, EFF_MINILOOP, $02, <(mc_pattern21loop-*)
mc_pattern21loop2:
  .byte A3+1, AS3, C4+1, D4, EFF_MINILOOP, $05, <(mc_pattern21loop2-*)
mc_pattern21loop3:
  .byte AS3+1, C4, D4+1, F4, EFF_MINILOOP, $08, <(mc_pattern21loop3-*)
mc_pattern21loop4:
  .byte C4+1, D4, F4+1, G4, EFF_MINILOOP, $0B, <(mc_pattern21loop4-*)
  .byte EFF_DIVISOR, $FF
  .byte G4+1, $0, A4, $6, GS4, $3, G4, $3, G4+1, $3
  .byte INST1, $FF
  .byte G4, vibrato, $7, G4, lead50vibrato, $1B, G4, tridrum, $0, OFF, lead12, $6
  .byte D4+1, $0, E4, lead12, $2, D4, lead12, $3, C4+1, $3, C4, vibrato2, $13, C4, slidedown2, $0, OFF, lead12, $2
mc_pattern21loop5:
  .byte C4+1, $1, D4, lead12, $1, F4+1, $3, EFF_MINILOOP, $0D, <(mc_pattern21loop5-*), D4+1, $3
  .byte F4+1, $0, G4, lead12, $2, G4, vibrato, $7, G4, lead50vibrato, $11, EFF_DIVISOR, $00, G4, tridrum, OFF, lead12
  .byte INST1, lead254
  .byte INST2, lead25
  .byte JUMP, <(mc_pattern9loop-*)

mc_pattern13:
  .byte INST1, $FF
  .byte INST2, guit12
  .byte EFF_DIVISOR, $FF
  .byte C5+1, $0, D5, lead12, $2, C5, lead12, $3, A4, guit50, $3, A4, vibrato, $13, A4, tridrum, $0, OFF, lead12, $6, F4+1, $7, G4+1, $7, A4+1, $3, AS4, lead12, $3, A4+1, $3, A4, vibrato, $7, A4, lead50vibrato, $11, EFF_DIVISOR, $00, A4, tridrum, OFF, lead12
  .byte INST1, lead254
  .byte INST2, lead25
  .byte JUMP, <(mc_pattern9loop-*)

mc_pattern9:
  .byte INST1, lead254
  .byte EFF_DIVISOR, $00
mc_pattern9loop:
  .byte D4+1, A3, C4+1, D4, E4+1, C4, F4+1, E4, G4+1, F4, E4+1, G4, C4+1, E4, A3+1, C4
  .byte JUMP, <(mc_pattern9loop-*)

mc_pattern14:
  .byte INST1, $FF
  .byte INST2, guit12
  .byte EFF_DIVISOR, $FF
mc_pattern14loop:
  .byte F5+1, $0, G5, lead12, $2, OFF, lead12, $1, EFF_MINILOOP, 0, <(mc_pattern14loop-*)
  .byte F5+1, $0, G5, lead12, $2, G5, vibrato, $0F, G5, slidedown2, $0, OFF, lead12, $6
  .byte C4+1, $0, D4, lead12, $2, C4+1, $B, G3+1, $0, AS3, lead12, $2, A3+1, $7, A3, vibrato2, $7, A3, lead50vibrato2, $11, EFF_DIVISOR, $00, A3, tridrum, OFF, lead12
  .byte INST1, lead254
  .byte INST2, lead25
  .byte JUMP, <(mc_pattern9loop-*)

mc_pattern17:
  .byte INST1, lead12
  .byte INST2, guit12
mc_pattern17loop:
  .byte F3+1, I, G3, I, AS3+1, I, C4, I, EFF_MINILOOP, 4, <(mc_pattern17loop-*)
  .byte C4+1, D4, I, EFF_MINILOOPFLAG, $00, I, OFF, DELAY3, t1hbeat
  .byte JUMP, <(mc_pattern17loop-*)

mc_pattern18:
mc_pattern18loop:
  .byte G2 ,AS2, D3, F3
  .byte JUMP, <(mc_pattern18loop-*)

mc_pattern19:
mc_pattern19loop:
  .byte G3+1, I, A3, I, C4+1, I, D4, I, EFF_MINILOOP, 4, <(mc_pattern19loop-*)
  .byte E4+1, FS4, I, EFF_MINILOOPFLAG, $00, I, OFF, DELAY3, t1hbeat
  .byte JUMP, <(mc_pattern19loop-*)

mc_pattern20:
mc_pattern20loop:
  .byte F2 ,A2, C3, E3
  .byte JUMP, <(mc_pattern20loop-*)

mc_pattern22:
  .byte N3+1
mc_pattern22loop:
  .byte I
  .byte JUMP, <(mc_pattern22loop-*)

mc_pattern25:
  .byte INST1, bell
  .byte EFF_DIVISOR, $FF
mc_pattern25loop:
  .byte G1, $1F, EFF_MINILOOP, 2, <(mc_pattern25loop-*)
mc_pattern25loop2:
  .byte G1, $7, AS1, $3, C2, $3, JUMP, <(mc_pattern25loop2-*)

mc_songend:
