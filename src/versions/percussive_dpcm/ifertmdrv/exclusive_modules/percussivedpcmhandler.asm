  LDA DPCMready ; DPCM BUFFER HANDLER
  CMP #$00
  BEQ ignoredpcm
  LSR a
  LSR a
  LSR a
  LSR a
  TAX
  LDY #$00
dpcmloop:
  LDA dpcmtbl,x
  STA $4010,y
  INX
  INY
  CPY #$4
  BNE dpcmloop
  LDA #$0F
  STA $4015
  LDA #$1F
  STA $4015
  LDA #$00
  STA DPCMready
ignoredpcm:
