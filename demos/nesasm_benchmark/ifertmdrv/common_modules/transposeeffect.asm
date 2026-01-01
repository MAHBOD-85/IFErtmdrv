  LDA [TMPpataddr],y
  CMP #$FB
  BNE skipfb
  INY
  LDA [TMPpataddr],y
  STA CHXtranspose,x
  INY

skipfb:
