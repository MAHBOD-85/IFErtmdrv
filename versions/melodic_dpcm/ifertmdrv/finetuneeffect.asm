  LDA [TMPpatddr],y
  CMP #$FA
  BNE skipfawithdelay
  INC <TMPpatddr
  LDA [TMPpatddr],y
  STA CHXbasefinetune,x
  INC <TMPpatddr
skipfawithdelay:

skipfa:
