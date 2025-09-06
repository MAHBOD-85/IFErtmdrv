  LDA [TMPpatddr],y
  CMP #$F4
  BNE skipf4withdelay
  INC <TMPpatddr
  LDA [TMPpatddr],y
  STA CHXdivisorcount,x
  INC <TMPpatddr
skipf4withdelay:

skipf4:
