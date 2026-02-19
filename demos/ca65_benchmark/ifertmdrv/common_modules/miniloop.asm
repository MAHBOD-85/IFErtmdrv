  ; Normally this effect is expected to come first so jump compensation is not added here.

  LDA (TMPpataddr),y
  CMP #$F9
  BNE skipf9
  INY
  LDA (TMPpataddr),y
  CMP CHXminiloopflag,x
  BCC miniloophaspassed
  INC CHXminiloopflag,x
  INY
  LDA (TMPpataddr),y
  ADC #$01
  BMI minusf9jump

  ADC <TMPpataddr
  LDY #$00
  STA <TMPpataddr
  BCC skipf9
  INC <TMPpataddr+1
  BCS skipf9

minusf9jump:

  ADC <TMPpataddr
  LDY #$00
  STA <TMPpataddr
  BCS skipf9
  DEC <TMPpataddr+1
  BCC skipf9

miniloophaspassed:
  INY
  INY

skipf9:

  LDA (TMPpataddr),y
  CMP #$F8
  BNE skipf8
  INY
  LDA (TMPpataddr),y
  STA CHXminiloopflag,x
  INY

skipf8:
