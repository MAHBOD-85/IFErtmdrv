  LDA [TMPpatddr],y
  AND #$FC
  CMP #$F0
  BNE skipfxwithdelay
  LDA [TMPpatddr],y
  CLC
  ADC CHXspeed,x
  AND #$03
  STA CHXspeed,x

  INC <TMPpatddr
  LDA [TMPpatddr],y

  LDX <Region
  CPX #$01
  BCC skipdelayspeedcorrect
  ADC #$7F
skipdelayspeedcorrect:

  TAX
  LDA speedtbl,x
  LDX channel
  STA CHXframetimer,x
  INC <TMPpatddr
skipfxwithdelay:

skipfx:
