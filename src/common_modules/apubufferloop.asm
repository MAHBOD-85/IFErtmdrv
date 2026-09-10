  LDA APUregbuffer+8
  AND #$0F
  STA APUregbuffer+8

  LDX #$00
audioloop:

  LDA CHXmutetimer,x
  BEQ dontdecrementmute

  DEC CHXmutetimer,x
  JMP ignorebufferwrite
dontdecrementmute:

audiosubloop:
  LDA APUregbuffer,x
  STA $4000,x
  INX
  TXA
  AND #$03
  CMP #$03
  BNE audiosubloop

  LDA APUregbuffer,x
  CMP shitFuckRegPrev,x
  BEQ bufferwritten

  STA $4000,x
  STA shitFuckRegPrev,x
  JMP bufferwritten

ignorebufferwrite:
  INX
  INX
  INX
bufferwritten:

  INX
  CPX #$10
  BNE audioloop

  LDA APUregbuffer+$B
  STA $400B
