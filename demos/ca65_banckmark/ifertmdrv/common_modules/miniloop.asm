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

  LDA (TMPpatddr),y
  CMP #$F8
  BNE skipf8withdelay
  INC <TMPpatddr
  LDA (TMPpatddr),y
  STA CHXminiloopflag,x
  INC <TMPpatddr
skipf8withdelay:

skipf8:
