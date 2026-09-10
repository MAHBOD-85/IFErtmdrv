  STY ExtraReg

  LDA (TMPpataddr),y
  CMP #$FF
  BNE skipff

  INY
  LDA (TMPpataddr),y
  ADC ExtraReg
  CLC
  BMI minusffjump

  ADC <TMPpataddr
  STA <TMPpataddr
  LDY #$00
  BCC skipff
  INC <TMPpataddr+1
  BCS skipff

minusffjump:

  ADC <TMPpataddr
  STA <TMPpataddr
  LDY #$00
  BCS skipff
  DEC <TMPpataddr+1

skipff:
