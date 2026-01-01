  LDA [TMPpataddr],y
  CMP #$FA
  BNE skipfa
  INY
  LDA [TMPpataddr],y
  STA CHXbasefinetune,x
  INY

skipfa:
