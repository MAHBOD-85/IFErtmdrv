  LDA (TMPpatddr),y
  CMP #$FB
  BNE skipfbwithdelay
  INC <TMPpatddr
  LDA (TMPpatddr),y
  STA CHXtranspose,x
  INC <TMPpatddr
skipfbwithdelay:

skipfb:
