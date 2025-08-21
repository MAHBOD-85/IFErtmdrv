  LDA [TMPpatddr],y       ; |
  CMP #$FA                ; |
  BNE skipfawithdelay     ; |
  INC TMPpatddr           ; |
  LDA [TMPpatddr],y       ; |
  STA CHXbasefinetune,x   ;  >  FINETUNE EFFECT
  INC TMPpatddr           ; |
skipfawithdelay:          ; |
                          ; |
skipfa:                   ; |
