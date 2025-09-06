  LDA DPCMready ; DPCM BUFFER HANDLER
  BEQ ignoredpcm
  AND #$0F
  ORA dpcmtbl,x
  STA $4010
  LDA DPCMready
  AND #$F0
  LSR a
  LSR a
  TAX
  LDA dpcmtbl+1,x
  STA $4011
  LDA dpcmtbl+2,x
  STA $4012
  LDA dpcmtbl+3,x
  STA $4013
  LDA #$0F
  STA $4015
  LDA #$1F
  STA $4015
  LDX #$00
  STX DPCMready
ignoredpcm:
