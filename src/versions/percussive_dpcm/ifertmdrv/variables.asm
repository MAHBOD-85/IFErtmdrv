  .org $F0
TMPpatddr:
  .ds 2
songAddrProgress:
  .ds 1
songAddr:
  .ds 1
Region:
  .ds 1


  .org $710

CHXpataddr:      ; THIS OCCUPIES THE 2 SLOTS
shitFuckRegPrev: ; THIS OCCUPIES THE 4TH SLOT
  .ds 2
  .ds 1
  .ds 1
  .ds 12

APUregbuffer:
  .ds 16


DPCMready:
  .ds 1
ExtraReg:
  .ds 1
channel:
  .ds 1
currentPatternFrameTimer:
  .ds 1
currentPatternProgress:
  .ds 1
currentPatternSpeed:
  .ds 1
patternLength:
  .ds 1
patternSpeedX:
  .ds 4

  .ds 5


CHXbaseinst:
  .ds 1
CHXbaseinst2:
  .ds 1
CHXinstaddr:
  .ds 1
CHXinstdelay:
  .ds 1

  .ds 12


CHXnote:
  .ds 1
CHXtranspose:
  .ds 1
CHXfinetune:
  .ds 1
CHXbasefinetune:
  .ds 1

  .ds 12



CHXdivisorprogress:
  .ds 1
CHXdivisorcount:
  .ds 1
CHXaccountfordivisorflag:
  .ds 1
CHXaccountfordivisor:
  .ds 1

  .ds 12


CHXframetimer:
  .ds 1
CHXspeed:
  .ds 1
CHXmutetimer:
  .ds 1
CHXminiloopflag:
  .ds 1

  .ds 12
