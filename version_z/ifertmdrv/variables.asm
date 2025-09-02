Region = $00
TMPpatddr = $F0
songAddrProgress = $F2
songAddr = $F3


  .org $710

ExtraReg:
shitFuckRegPrev:
  .ds 1
DPCMready:
  .ds 1
channel:
  .ds 2
currentPatternFrameTimer:
  .ds 1
currentPatternProgress:
  .ds 1
currentPatternSpeed:
  .ds 2
patternLength:
  .ds 1

  .ds 7

APUregbuffer:
  .ds 20







patternSpeedX:
  .ds 4



CHXbaseinst:
  .ds 1
CHXbaseinst2:
  .ds 1
CHXinstaddr:
  .ds 1
CHXinstdelay:
  .ds 1

  .ds 16


CHXnote:
  .ds 1
CHXtranspose:
  .ds 1
CHXfinetune:
  .ds 1
CHXbasefinetune:
  .ds 1

  .ds 16



CHXdivisorprogress:
  .ds 1
CHXdivisorcount:
  .ds 1
CHXaccountfordivisorflag:
  .ds 1
CHXaccountfordivisor:
  .ds 1

  .ds 16


CHXframetimer:
  .ds 1
CHXspeed:
  .ds 1
CHXmutetimer:
  .ds 1
CHXminiloopflag:
  .ds 1

  .ds 16

CHXpataddr:
