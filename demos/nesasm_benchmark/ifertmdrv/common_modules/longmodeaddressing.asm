
  LDA [songAddrProgress],y
  BEQ ordersnop
  INY
  STA CHXpataddr+1,x
  LDA [songAddrProgress],y
  STA CHXpataddr,x
  LDA #$00
  STA CHXspeed,x
  STA CHXframetimer,x
  STA CHXminiloopflag,x
  LDA CHXdivisorcount,x
  STA CHXdivisorprogress,x
ordersnop:
  INX
  INX
  INX
  INX
  INY
  CPX #$10
  BNE ordersetloop
