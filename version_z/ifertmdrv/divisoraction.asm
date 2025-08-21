  LDA CHXdivisorprogress,x
  CMP CHXdivisorcount,x
  BCS skipdivisor
  INC CHXdivisorprogress,x
  JMP patternend
skipdivisor:
  LDA #$00
  STA CHXdivisorprogress,x
