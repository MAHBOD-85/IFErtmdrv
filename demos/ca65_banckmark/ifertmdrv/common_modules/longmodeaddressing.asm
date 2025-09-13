  ; TAKE THIS ONE WITH A HUGE MOUNTAIN OF SALT

  LDA (songAddrProgress),y
  INY
  CMP #$FF
  BEQ ordersnop1
  STA CHXpataddr,x
  INY
  LDA (songAddrProgress),y
  LSR a
  LSR a
  LSR a
  LSR a
  CLC
  ADC SongAddr
  STA CHXpataddr+1,x
  LDA #$00
  STA CHXspeed,x
  STA CHXframetimer,x
  STA CHXminiloopflag,x
  DEY
ordersnop1:
  INX
  INX
  INX
  INX

  LDA (songAddrProgress),y
  INY
  CMP #$FF
  BEQ ordersnop1
  STA CHXpataddr,x
  LDA (songAddrProgress),y
  AND #$0F
  CLC
  ADC SongAddr
  STA CHXpataddr+1,x
  LDA #$00
  STA CHXspeed,x
  STA CHXframetimer,x
  STA CHXminiloopflag,x
ordersnop2:
  INX
  INX
  INX
  INX
  INY
  CPX #$10
  BNE ordersetloop

