Region = $00
CHXpataddr = $740
TMPpatddr = $F0
songAddrProgress = $F8
songAddr = $F9
songCommand = $730
channel = $712

currentPatternFrameTimer = $734
currentPatternProgress = $735
currentPatternSpeed = $736
patternLength = $737

patternSpeedX = $738

CHXspeed = $742
CHXbaseinst = $743
CHXbaseinst2 = $754
CHXfinetune = $755
CHXbasefinetune = $756

CHXinstdelay = $757

CHXframetimer = $768

CHXinstaddr = $769

CHXnote = $76A

CHXminiloopflag = $76B

CHXtranspose = $77C

CHXmutetimer = $77D
CHXdivisorprogress = $77E
CHXdivisorcount = $77F


DPCMframecounter = $731
DPCMready = $711

ExtraReg = $710

shitFuckRegPrev = $710


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; IFEWARE'S REALTIME AUDIO DRIVER TM BEGIN

  ; ORDERS TIMER


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



  ; ORDERS PARSER

  LDY #$00
  LDA [songAddrProgress],y
  CMP #$20
  BNE ordersnotjmp
  INY
  LDA [songAddrProgress],y
  TAX
  INY
  LDA [songAddrProgress],y
  STA songAddr
  BEQ nahitsprobablynothing
  STX songAddrProgress
nahitsprobablynothing:
  DEY
  DEY
ordersnotjmp:



  LDA [songAddrProgress],y
  CMP #$10
  BNE ignoreheader
  INY
  LDA [songAddrProgress],y
  STA patternLength
  LDX #$0
  INY
  STY ExtraReg
  LDA [songAddrProgress],y

  LDY <Region
  CPY #$01
  BCC skipspeedcorrect
  ADC #$7F
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





ordersnotspecialbyte:
  LDA patternSpeedX
  STA currentPatternFrameTimer
  LDX #$00
ordersetloop:




  LDA [songAddrProgress],y
  BEQ ordersnop
  AND #$F0
  STA CHXpataddr,x

  LDA [songAddrProgress],y
  AND #$0F
  CLC
  ADC songAddr
  STA CHXpataddr+1,x


  LDA #$00
  STA CHXspeed,x
  STA CHXframetimer,x
  STA CHXminiloopflag,x
ordersnop:
  INX
  INX
  INX
  INX
  INY
  CPX #$14
  BNE ordersetloop
  TYA
  CLC
  ADC songAddrProgress
  STA songAddrProgress

ordersend:



  ; PATTERN PARSER
  ; THIS CODE IS VERY VERY GROSS, MAY GOD HELP THE SOUL OF THOSE WHO TRY TO STUDY IT

  ;LDA #$5F
  ;STA $2001

  LDX #$00
  STX channel
patternparserloop:
  LDA CHXpataddr,x
  STA TMPpatddr
  LDA CHXpataddr+1,x
  STA TMPpatddr+1


  .include "ifertmdrv/divisoraction.asm"




  LDA CHXframetimer,x
  DEC CHXframetimer,x
  CMP #$00
  BNE skipresetchannelspeed
  LDX channel
  LDA CHXspeed,x
  TAX
  LDA patternSpeedX,x
  LDX channel
  STA CHXframetimer,x
  INC CHXspeed,x
  LDA CHXspeed,x
  CMP #$04
  BCC skipthisthingtootwo
  SBC #$04
  STA CHXspeed,x
  JMP skipthisthingtootwo
skipresetchannelspeed:
  JMP patternend
skipthisthingtootwo:

  LDY #$00


  .include "ifertmdrv/miniloop.asm"



  LDA [TMPpatddr],y
  CMP #$FC
  BNE skipfcwithdelay
  INC TMPpatddr
  LDA [TMPpatddr],y
  STA CHXbaseinst,x
  INC TMPpatddr
skipfcwithdelay:

skipfc:


  .include "ifertmdrv/secondinsteffect.asm"

  .include "ifertmdrv/transposeeffect.asm"

  .include "ifertmdrv/finetuneeffect.asm"


  LDA [TMPpatddr],y
  CMP #$FF
  BNE skipffwithdelay
  INY
  LDA [TMPpatddr],y
  DEY
  STA TMPpatddr
skipffwithdelay:

skipff:





  .include "ifertmdrv/divisoreffect.asm"



  LDX channel

  LDA [TMPpatddr],y
  CMP #$FE
  BNE skipfe
  INC TMPpatddr
  JMP instisimmediate

skipfe:
  LDA #$00
  STA CHXinstdelay,x
  LDA CHXbasefinetune,x
  STA CHXfinetune,x

  LDA [TMPpatddr],y

  .include "ifertmdrv/transposeaction.asm"

  AND #$FE
  STA CHXinstaddr+1,x

  .include "ifertmdrv/secondinstaction.asm"


  LDA CHXbaseinst,x
  CMP #$FF
  BNE instisreatined
  LDA [TMPpatddr],y
  STA CHXinstaddr,x




  INC TMPpatddr
  JMP instisimmediate
instisreatined:
  LDA CHXbaseinst,x
  STA CHXinstaddr,x
instisimmediate:



  .include "ifertmdrv/sequencebreak.asm"



patternend:

  LDY #$00
  LDA TMPpatddr
  STA CHXpataddr,x
  LDA TMPpatddr+1
  STA CHXpataddr+1,x
  INX
  INX
  INX
  INX
  STX channel
  CPX #$14
  BEQ patternendforrealz
  JMP patternparserloop
patternendforrealz:



  ; GROSS CODE FINISHED #############################################



  ; INSTRUMENT LOOP


  ;LDA #$1B
  ;STA $2001


  LDX #$00
instloop:

  LDA CHXinstdelay,x
  BEQ ignoredelay

  CMP #$FF
  BEQ dontdecrementdelay
  DEC CHXinstdelay,x
dontdecrementdelay:
  JMP instloopskip



ignoredelay:



  LDY CHXinstaddr,x
  LDA instrument,y
  CMP #$C0
  BNE notspecialbytewithdelay
specialbyte:
  INC CHXinstaddr,x
  LDA instrument2,y
  STA CHXinstaddr,x
  TAY
  LDA instrument,y

notspecialbytewithdelay:
  CMP #$E0
  BEQ instnop





notspecialbyte:
  STA $720,x
instnop:
  LDA instrument2,y
  AND #$01
  BNE instsetfinetune
  LDA instrument2,y
  CLC
  ADC CHXnote,x
  STA CHXnote,x
  INC CHXinstaddr,x
  JMP instdelay
instsetfinetune:
  LDA instrument2,y
  AND #$FE
  CLC
  ADC CHXfinetune,x
  STA CHXfinetune,x
  INC CHXinstaddr,x


instdelay:
  LDY CHXinstaddr,x
  LDA instrument,y
  CMP #$D0
  BNE ignoreinstdelaywithdelay
  LDA instrument2,y

  LDY <Region
  CPY #$01
  BCC skipspeedcorrect2
  ADC #$7F
skipspeedcorrect2:

  TAY
  LDA speedtbl,y
  STA CHXinstdelay,x
  INC CHXinstaddr,x
ignoreinstdelaywithdelay:


ignoreinstdelay:

instloopskip:
  INX
  INX
  INX
  INX
  CPX #$14
  BEQ instloopend
  JMP instloop

instloopend:






  LDY #$00
notewriteloop:
  LDX CHXnote,y


  LDA <Region
  CMP #$01
  BNE skippitchcorrect
  CPY #$0C
  BEQ skippitchcorrect
  INX
  INX
skippitchcorrect:




  LDA freqtbl,x
  STA $722,y
  INX
  LDA freqtbl,x
  STA $723,y



  .include "ifertmdrv/finetuneaction.asm"






  INY
  INY
  INY
  INY
  CPY #$10
  BNE notewriteloop

  lda $730
  AND #$3F
  jsr zsaw_set_volume
  lda $730
  LSR a
  LSR a
  LSR a
  LSR a
  LSR a
  AND #$06
  jsr zsaw_set_timbre
  lda CHXnote + $10
  LSR a
  CLC
  ADC #$fe
  jsr zsaw_play_note ; enables DMC IRQ


  ;LDA #$3F
  ;STA $2001

  ; AUDIO BUFFER WRITE

  LDA $728
  AND #$0F
  STA $728










  LDX #$00
audioloop:

  LDA CHXmutetimer,x
  BEQ dontdecrementmute
  DEC CHXmutetimer,x
  JMP ignorebufferwrite
dontdecrementmute:

audiosubloop:
  LDA $720,x
  STA $4000,x
  INX
  TXA
  AND #$03
  CMP #$03
  BNE audiosubloop
  LDA $720,x
  CMP shitFuckRegPrev,x
  BEQ bufferwritten
  STA $4000,x
  STA shitFuckRegPrev,x
  JMP bufferwritten

ignorebufferwrite:
  INX
  INX
  INX
bufferwritten:

  INX
  CPX #$10
  BNE audioloop



  LDA $72B
  STA $400B


  ; AUDIO BUFFER WRITE FINISH




  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; IFEWARE'S REALTIME AUDIO DRIVER TM END
