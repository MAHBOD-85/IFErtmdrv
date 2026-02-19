
  LDA (TMPpataddr),y
  CMP #$FD
  BNE skipfd
  INY
  LDA (TMPpataddr),y
  STA CHXbaseinst2,x
  INY

skipfd:
