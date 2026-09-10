  LDY #$00
  LDA (songAddrProgress),y
  CMP #$21
  BNE ordersnotjmp

  INY
  LDA (songAddrProgress),y
  TAX
  INY
  LDA (songAddrProgress),y
  STX <songAddrProgress
  STA <songAddr
  DEY
  DEY
ordersnotjmp:
