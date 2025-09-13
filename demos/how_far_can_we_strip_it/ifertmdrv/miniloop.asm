  LDA (TMPpatddr),y
  CMP #$F9
  BNE skipf9withdelay
  INC <TMPpatddr
  LDA (TMPpatddr),y
  CMP CHXminiloopflag,x
  BCC miniloophaspassed
  INC CHXminiloopflag,x
  INC <TMPpatddr
  LDA (TMPpatddr),y
  STA <TMPpatddr
  BCS skipf9

miniloophaspassed:
  INC <TMPpatddr
  INC <TMPpatddr

skipf9withdelay:

skipf9:

