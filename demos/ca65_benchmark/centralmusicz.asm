mc_songstart:
  .byte PAT_INFO, $7F, $00

  .byte >mc_pattern3, <mc_pattern3
  .byte >mc_pattern5, <mc_pattern5
  .byte >mc_pattern2, <mc_pattern2
  .byte >mc_pattern6, <mc_pattern6
  .byte >mc_pattern4, <mc_pattern4

  .byte PAT_JUMP
  .word mc_songstart



mc_pattern1:
  .byte INST1, $00
mc_pattern1loop:
  .byte OFF
  .byte JUMP, <(mc_pattern1loop-*)


mc_pattern2:
  .byte INST1, $17
mc_pattern2loop:
  .byte C4, I
  .byte JUMP, <(mc_pattern2loop-*)

mc_pattern3:
  .byte INST1, $02
mc_pattern3loop:
  .byte AS4, I, A4, I, G4, DS4, I, C4, I, I, I, C4, D4, DS4, I, I
  .byte A4, I, G4, I, I, I, I, DS5, I, D5, C5, I, B4, I, C5, I
  .byte JUMP, <(mc_pattern3loop-*)

mc_pattern4:
  .byte INST1, $14
mc_pattern4loop:
  .byte C2, I, C2, C2, C3, G2, FS2, F2, I, F2, I, DS2, F2, G2, DS2, D2
  .byte JUMP, <(mc_pattern4loop-*)

mc_pattern5:
  .byte INST1, $2
  .byte EFF_TRANSPOSE, $F6
  .byte JUMP, <(mc_pattern3loop-*)

mc_pattern6:
  .byte INST1, $04
  .byte INST2, $09
mc_pattern6loop:
  .byte N0, N0, N7+1, N0
  .byte JUMP, <(mc_pattern6loop-*)
