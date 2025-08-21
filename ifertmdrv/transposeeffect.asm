  LDA [TMPpatddr],y       ; |
  CMP #$FB                ; |
  BNE skipfbwithdelay     ; |
  INC TMPpatddr           ; |
  LDA [TMPpatddr],y       ; |
  STA CHXtranspose,x      ;  >  TRANSPOSE EFFECT
  INC TMPpatddr           ; |
skipfbwithdelay:          ; |
                          ; |
skipfb:                   ; |
