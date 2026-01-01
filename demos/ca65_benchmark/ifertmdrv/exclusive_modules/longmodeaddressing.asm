
  LDA (songAddrProgress),y
  BEQ ordersnop
  INY
  STA CHXpataddr,x
  LDA (songAddrProgress),y
  STA CHXpataddr+1,x
  LDA #$00
  STA CHXspeed,x
  STA CHXframetimer,x
  STA CHXminiloopflag,x
  LDA CHXdivisorcount,x
  STA CHXdivisorprogress,x
ordersnop:
  INY
  INX
  INX
  INX
  INX
  CPX #$14
  BNE ordersetloop
