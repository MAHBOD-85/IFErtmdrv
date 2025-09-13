  LDA (TMPpatddr),y
  INC <TMPpatddr
  AND #$01
  BEQ notinst2
  LDA CHXbaseinst2,x
  STA CHXinstaddr,x
  BPL instisimmediate
notinst2:
