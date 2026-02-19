
genbcd_result = $88

genbcd:
  STX ExtraReg
  LDX #$00
genbcd100loop:
  SEC
  SBC #100
  INX
  BCS genbcd100loop
  ADC #100
  DEX
  STX genbcd_result
  LDX #$00
genbcd10loop:
  SEC
  SBC #10
  INX
  BCS genbcd10loop
  ADC #10
  DEX
  STX genbcd_result+1
  STA genbcd_result+2
  LDX ExtraReg
  RTS



