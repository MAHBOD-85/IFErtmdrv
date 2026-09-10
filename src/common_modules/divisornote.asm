  LDA CHXdivisorcount,x
  CMP #$FF
  BNE divisorisretained

  INY
  LDA (TMPpataddr),y

divisorisretained:
  STA CHXdivisorcountimm,x

divisorisimmediate:
