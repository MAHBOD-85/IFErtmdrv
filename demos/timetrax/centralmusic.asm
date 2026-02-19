lead25 = $00
lead25c = $02
arpmaj = $06
arpmin = $0C
hihat = $10
arpmaj4 = $14
guit50 = $16
lead50 = $18
guit12 = $1A
lead12 = $1C
kick = $1E
snare = $24
slideup = $2B
slidedown = $2E
slidedown2 = $31
bass = $33
tridrum = $37
lead254 = $39
arp12 = $3B
ohihat = $3D
vibrato = $44
vibrato2 = $4C
lead50vibrato = $54
lead50vibrato2 = $56
buzz = $58
buzzchug = $5F
hiride = $64
loride = $69
bell = $6F

t4beat = $06
thbeat = $05
t1beat = $04
t3beat = $07
t2hbeat = $0B
t2qbeat = $0D
tlast7from8 = $0C
t2beat = $0E
t1hbeat = $0F
t3hbeat = $10

mc_songstart:
  .byte PAT_INFO, $3F, $00

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
  .byte G2, slideup, DELAY3, thbeat, G3+1, DELAY3, thbeat, G3+1, DELAY3, t3beat, G3, slidedown, DELAY3, thbeat, G2+1, DELAY3, thbeat, G2+1, DELAY3, t3beat, G3, slideup, DELAY3, thbeat, G4+1, DELAY3, thbeat, G4+1, DELAY3, t3beat, G4, slidedown2, DELAY3, thbeat, G2+1, DELAY3, thbeat, G2+1, DELAY3, t3beat
  .byte D3, slideup, DELAY3, thbeat, D4+1, DELAY3, thbeat, D4+1, DELAY3, t3beat, F4+1, DELAY3, t4beat, F3, slideup, DELAY3, thbeat, F4+1, DELAY3, thbeat, F4+1, DELAY3, t3beat, G4+1, DELAY3, t4beat

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
mc_pattern21loop:
  .byte F3+1, I, G3, I, AS3+1, I, C4, I, EFF_MINILOOP, $02, <(mc_pattern21loop-*)
mc_pattern21loop2:
  .byte A3+1, I, AS3, I, C4+1, I, D4, I, EFF_MINILOOP, $05, <(mc_pattern21loop2-*)
mc_pattern21loop3:
  .byte AS3+1, I, C4, I, D4+1, I, F4, I, EFF_MINILOOP, $08, <(mc_pattern21loop3-*)
mc_pattern21loop4:
  .byte C4+1, I, D4, I, F4+1, I, G4, I, EFF_MINILOOP, $0B, <(mc_pattern21loop4-*)
  .byte G4+1, A4, DELAY2, tlast7from8, GS4, DELAY3, thbeat, G4, DELAY3, thbeat, G4+1, DELAY3, thbeat
  .byte INST1, $FF
  .byte G4, vibrato, DELAY3, t1beat, G4, lead50vibrato, DELAY3, t3hbeat, G4, tridrum, OFF, lead12, DELAY2, tlast7from8
  .byte D4+1, E4, lead12, I, I, D4, lead12, DELAY3, thbeat, C4+1, DELAY3, thbeat, C4, vibrato2, DELAY3, t2hbeat, C4, slidedown2, OFF, lead12, I, I
mc_pattern21loop5:
  .byte C4+1, I, D4, lead12, I, F4+1, DELAY3, thbeat, EFF_MINILOOP, $0D, <(mc_pattern21loop5-*), D4+1, DELAY3, thbeat
  .byte F4+1, G4, lead12, I, I, G4, vibrato, DELAY3, t1beat, G4, lead50vibrato, DELAY1, t2qbeat, G4, tridrum, OFF, lead12
  .byte INST1, lead254
  .byte INST2, lead25
  .byte JUMP, <(mc_pattern9loop-*)

mc_pattern13:
  .byte INST1, $FF
  .byte INST2, guit12
  .byte C5+1, D5, lead12, I, I, C5, lead12, DELAY3, thbeat, A4, guit50, DELAY3, thbeat, A4, vibrato, DELAY3, t2hbeat, A4, tridrum, OFF, lead12, DELAY2, tlast7from8, F4+1, DELAY3, t1beat, G4+1, DELAY3, t1beat, A4+1, DELAY3, thbeat, AS4, lead12, DELAY3, thbeat, A4+1, DELAY3, thbeat, A4, vibrato, DELAY3, t1beat, A4, lead50vibrato, DELAY1, t2qbeat, A4, tridrum, OFF, lead12
  .byte INST1, lead254
  .byte INST2, lead25
  .byte JUMP, <(mc_pattern9loop-*)

mc_pattern9:
  .byte INST1, lead254
mc_pattern9loop:
  .byte D4+1, A3, C4+1, D4, E4+1, C4, F4+1, E4, G4+1, F4, E4+1, G4, C4+1, E4, A3+1, C4
  .byte JUMP, <(mc_pattern9loop-*)

mc_pattern14:
  .byte INST1, $FF
  .byte INST2, guit12
mc_pattern14loop:
  .byte F5+1, G5, lead12, I, I, OFF, lead12, I, EFF_MINILOOP, 0, <(mc_pattern14loop-*)
  .byte F5+1, G5, lead12, I, I, G5, vibrato, DELAY3, t2beat, G5, slidedown2, OFF, lead12, DELAY2, tlast7from8
  .byte C4+1, D4, lead12, I, I, C4+1, DELAY3, t1hbeat, G3+1, AS3, lead12, I, I, A3+1, DELAY3, t1beat, A3, vibrato2, DELAY3, t1beat, A3, lead50vibrato2, DELAY1, t2qbeat, A3, tridrum, OFF, lead12
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
mc_pattern25loop:
  .byte G1, DELAY3, t4beat, EFF_MINILOOP, 2, <(mc_pattern25loop-*)
mc_pattern25loop2:
  .byte G1, DELAY3, t1beat, AS1, DELAY3, thbeat, C2, DELAY3, thbeat, JUMP, <(mc_pattern25loop2-*)

mc_songend:
