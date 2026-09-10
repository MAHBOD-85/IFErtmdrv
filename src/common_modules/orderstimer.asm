  LDX currentPatternFrameTimer
  DEC currentPatternFrameTimer
  CPX #$00
  BNE skippatternprogressincrement

  LDY currentPatternSpeed
  LDA patternSpeedX,y
  INC currentPatternSpeed
  STA currentPatternFrameTimer
  CPY #$03
  BNE skipresetpatternspeed

  LDY #$00
  STY currentPatternSpeed

skipresetpatternspeed:
  LDX currentPatternProgress
  INC currentPatternProgress
  CPX patternLength
  BNE skippatternprogressincrement

  LDX #$00
  STX currentPatternProgress
  JMP skipthisthingtoo

skippatternprogressincrement:
  JMP ordersend

skipthisthingtoo:
