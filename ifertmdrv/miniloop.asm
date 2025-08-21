  LDA [TMPpatddr],y
  CMP #$F9
  BNE skipf9withdelay
  INY
  LDA [TMPpatddr],y
  CMP CHXminiloopflag,x
  BCC miniloophaspassed

  INC CHXminiloopflag,x
  INY
  LDA [TMPpatddr],y
  STA TMPpatddr
  LDY #$00
  JMP skipf9

miniloophaspassed:
  INC TMPpatddr
  INC TMPpatddr
  INC TMPpatddr
  DEY

skipf9withdelay:

skipf9:

  LDA [TMPpatddr],y       ; |
  CMP #$F8                ; |
  BNE skipf8withdelay     ; |
  INC TMPpatddr           ; |
  LDA [TMPpatddr],y       ; |
  STA CHXminiloopflag,x   ;  >  SET MINILOOP FLAG EFFECT
  INC TMPpatddr           ; |
  ; FIXME FIXME           ; |
skipf8withdelay:          ; |
                          ; |
skipf8:                   ; |
