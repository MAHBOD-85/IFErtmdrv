  LDA [TMPpataddr],y
  AND #$FC
  CMP #$F0
  BNE skipfx
  LDA [TMPpataddr],y
  CLC
  ADC CHXspeed,x
  AND #$03
  STA CHXspeed,x

  INY
  LDA [TMPpataddr],y

  LDX <Region
  CPX #$01
  BCC skipdelayspeedcorrect
  ADC #$7F
skipdelayspeedcorrect:

  TAX
  LDA speedtbl,x
  LDX channel
  STA CHXframetimer,x
  STA CHXaccountfordivisor,x     ; DIVISOR INTEROP CODE
  INC CHXaccountfordivisorflag,x ; DIVISOR INTEROP CODE
  INY
skipfx:
