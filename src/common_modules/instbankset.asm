  LDA (songAddrProgress),y
  CMP #$22
  BNE ignoreinstbankset
  INY
  LDA (songAddrProgress),y
  STA instBank
  INY
  LDA (songAddrProgress),y
  STA instBank+1
  INY
ignoreinstbankset:
