
  LDA CHXnote,y
  CMP #$A0
  BCS dontfinetune

  LDA CHXfinetune,y
  CMP #$80
  ROR a
  CLC
  ADC APUregbuffer+2,y
  STA APUregbuffer+2,y

dontfinetune:
