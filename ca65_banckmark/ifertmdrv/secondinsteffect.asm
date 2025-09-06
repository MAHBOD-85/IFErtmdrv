
  LDA (TMPpatddr),y
  CMP #$FD
  BNE skipfdwithdelay
  INC <TMPpatddr
  LDA (TMPpatddr),y
  STA CHXbaseinst2,x
  INC <TMPpatddr
skipfdwithdelay:

skipfd:
