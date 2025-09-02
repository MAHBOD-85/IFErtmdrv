Region = $00
TMPpatddr = $F0
songAddrProgress = $F2
songAddr = $F3


  .org $710

CHXpataddr:
shitFuckRegPrev:
  .ds 2
CHXminiloopflag:
  .ds 2
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
