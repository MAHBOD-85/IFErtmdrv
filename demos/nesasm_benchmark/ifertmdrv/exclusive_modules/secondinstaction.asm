  LDA [TMPpataddr],y
  AND #$01
  BEQ notinst2
  LDA CHXbaseinst2,x
  STA CHXinstaddr,x
  JMP skipdpcminst
notinst2:
