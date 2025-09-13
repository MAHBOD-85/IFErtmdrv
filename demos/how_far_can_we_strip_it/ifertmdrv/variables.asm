  .segment "ZEROPAGE"
TMPpatddr:
  .res 1
  .res 1
songAddrProgress:
  .res 1
songAddr:
  .res 1
Region:
  .res 1
TMPPTR:
  .res 2
TMPPTR2:
  .res 2

CHXpataddr:      ; THIS OCCUPIES 2 SLOTS
shitFuckRegPrev: ; THIS OCCUPIES THE 4TH SLOT
  .res 2
  .res 1
  .res 1
  .res 12

APUregbuffer:
  .res 16


ExtraReg:
  .res 1
channel:
  .res 1
currentPatternFrameTimer:
  .res 1
currentPatternProgress:
  .res 1
currentPatternSpeed:
  .res 1
patternLength:
  .res 1
patternSpeedX:
  .res 4


CHXframetimer:
  .res 1
CHXminiloopflag:
  .res 1
CHXbaseinst:
  .res 1
CHXbaseinst2:
  .res 1


  .res 12


CHXnote:
  .res 1
CHXtranspose:
  .res 1
CHXfinetune:
  .res 1
CHXbasefinetune:
  .res 1

  .res 12



CHXdivisorprogress:
  .res 1
CHXdivisorcount:
  .res 1
CHXaccountfordivisorflag:
  .res 1
CHXaccountfordivisor:
  .res 1

  .res 12



  .res 1
CHXspeed:
  .res 1
CHXmutetimer:
  .res 1

CHXinstaddr:
  .res 1

  .res 12
