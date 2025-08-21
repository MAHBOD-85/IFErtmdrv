
  LDA CHXnote,y
  CMP #$A0
  BCS dontfinetune

  LDA CHXfinetune,y
  CMP #$80
  ROR a
  CLC
  ADC $722,y
  STA $722,y

dontfinetune:
