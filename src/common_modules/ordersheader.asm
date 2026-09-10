  LDA (songAddrProgress),y
  CMP #$20
  BNE ignoreheader

  INY
  LDA (songAddrProgress),y
  STA patternLength
  LDX #$0
  INY
  STY ExtraReg
  LDA (songAddrProgress),y

  LDY <Region
  CPY #$01
  BCC skipspeedcorrect
  ADC #palspeedtbl-speedtbl-1
skipspeedcorrect:
  TAY

speedsetloop:
  LDA speedtbl,y
  STA patternSpeedX,x
  INY
  INX
  CPX #$04
  BNE speedsetloop

  LDY ExtraReg
  INY

ignoreheader:
