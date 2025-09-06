  LDA CHXdivisorprogress,x
  CMP CHXdivisorcount,x
  BCS skipdivisor
  INC CHXdivisorprogress,x
  LDA CHXaccountfordivisorflag,x      ; SEQUENCE BREAK INTEROP CODE
  BEQ skipaccountingforsequencebreak  ; SEQUENCE BREAK INTEROP CODE
  LDA CHXaccountfordivisor,x          ; SEQUENCE BREAK INTEROP CODE
  STA CHXframetimer,x                 ; SEQUENCE BREAK INTEROP CODE
skipaccountingforsequencebreak:       ; SEQUENCE BREAK INTEROP CODE
  JMP patternend
skipdivisor:
  LDA #$00
  STA CHXdivisorprogress,x
  STA CHXaccountfordivisorflag,x      ; SEQUENCE BREAK INTEROP CODE
