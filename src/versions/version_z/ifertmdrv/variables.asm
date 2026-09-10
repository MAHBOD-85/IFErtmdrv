  .segment "ZEROPAGE"
TMPpataddr:
  .res 2
songAddrProgress:
  .res 1
songAddr:
  .res 1
instBank:
  .res 2
Region:
  .res 1


  .segment "BSS"

ExtraReg:
  .res 1
DPCMready:
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
zsawmodeswitch:
  .res 1

APUregbuffer:
  .res 16







patternSpeedX:
  .res 4



CHXbaseinst:
  .res 1
CHXbaseinst2:
  .res 1
CHXinstaddr:
  .res 1
CHXinstdelay:
  .res 1

  .res 16


CHXnote:
  .res 1
CHXtranspose:
  .res 1
CHXfinetune:
  .res 1
CHXbasefinetune:
  .res 1

  .res 16



CHXdivisorprogress:
  .res 1
CHXdivisorcount:
  .res 1
CHXaccountfordivisorflag:
  .res 1
CHXaccountfordivisor:
  .res 1

  .res 16


CHXframetimer:
  .res 1
CHXspeed:
  .res 1
CHXmutetimer:
  .res 1
CHXminiloopflag:
  .res 1

  .res 16

shitFuckRegPrev:
CHXpataddr:
  .res 2
CHXdivisorcountimm:
  .res 1
  .res 1

  .res 16
