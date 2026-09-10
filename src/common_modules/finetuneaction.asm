
  LDA CHXnote,x
  CMP #$A0
  BCS dontfinetune

  LDA CHXfinetune,x
  CMP #$80
  ROR a
  CLC
  BMI negativefinetune
  ADC APUregbuffer+2,x
  STA APUregbuffer+2,x
  BCC dontfinetune
  INC APUregbuffer+3,x
  BCS dontfinetune
negativefinetune:
  ADC APUregbuffer+2,x
  STA APUregbuffer+2,x
  BCS dontfinetune
  DEC APUregbuffer+3,x
dontfinetune:
