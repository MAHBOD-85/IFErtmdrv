
  LDA (songAddrProgress),y
  BEQ ordersnop
  AND #$F0
  STA CHXpataddr,x

  LDA (songAddrProgress),y
  AND #$0F
  CLC
  ADC <songAddr
  STA CHXpataddr+1,x


  LDA #$00
  STA CHXspeed,x
  STA CHXframetimer,x
  STA CHXminiloopflag,x
ordersnop:
  INX
  INX
  INX
  INX
  INY
  CPX #$10
  BNE ordersetloop
