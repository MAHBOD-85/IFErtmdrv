  LDA (TMPpataddr),y
  CMP #$F4
  BNE skipf4
  INY
  LDA (TMPpataddr),y
  STA CHXdivisorcount,x
  INY

skipf4:
