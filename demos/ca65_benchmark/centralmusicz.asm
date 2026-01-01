mc_songstart:
  .byte PAT_INFO, $7F, $00

  .word mc_pattern3
  .word mc_pattern5
  .word mc_pattern4
  .word mc_pattern6
  .word mc_pattern2

  .byte PAT_JUMP
  .word mc_songstart



mc_pattern1:
  .byte INST1, $00
mc_pattern1loop:
  .byte OFF
  .byte JUMP, <(mc_pattern1loop-*)


mc_pattern2:
mc_pattern2loop:
  .byte INST1, $16
  .byte JUMP, <(mc_pattern4loop-*)

mc_pattern3:
  .byte INST1, $02
mc_pattern3loop:
  .byte B3, B4, FS3, FS4, D3, D4, FS3, FS4, E3, E4, D4, CS4, B3, D4, CS4, B3
  .byte JUMP, <(mc_pattern3loop-*)

mc_pattern4:
  .byte INST1, $09
mc_pattern4loop:
  .byte B1, I, OFF, B1, OFF, I, B1, I, OFF, B1, OFF, B1, B2, I, A2, I
  .byte JUMP, <(mc_pattern4loop-*)

mc_pattern5:
  .byte INST1, $10
  .byte OFF
  .byte DELAY0, $4
  .byte JUMP, <(mc_pattern3loop-*)

mc_pattern6:
  .byte INST1, $0B
mc_pattern6loop:
  .byte N5, I, I, I
  .byte INST1, $0B
  .byte JUMP, <(mc_pattern6loop-*)
