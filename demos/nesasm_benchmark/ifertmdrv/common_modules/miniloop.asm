  ; Normally this effect is expected to come first so jump compensation is not added here.

  LDA [TMPpataddr],y
  CMP #$F9
  BNE skipf9
  INY
  LDA [TMPpataddr],y
  CMP CHXminiloopflag,x
  BCC miniloophaspassed
  INC CHXminiloopflag,x
  INC <TMPpataddr
  LDA [TMPpataddr],y
  BMI minusf9jump

  ADC <TMPpataddr
  STA <TMPpataddr
  LDA #$00
  DEY
  ADC <TMPpataddr+1
  STA <TMPpataddr+1
  JMP skipf9

minusf9jump:

  ADC <TMPpataddr
  STA <TMPpataddr
  LDA <TMPpataddr+1
  ADC #$FF
  STA <TMPpataddr+1
  DEY
  JMP skipf9

miniloophaspassed:
  INY
  INY

skipf9:

  LDA [TMPpataddr],y
  CMP #$F8
  BNE skipf8
  INY
  LDA [TMPpataddr],y
  STA CHXminiloopflag,x
  INY

skipf8:
