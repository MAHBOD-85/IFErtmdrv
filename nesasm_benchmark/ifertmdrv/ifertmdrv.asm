









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
  BEQ nahitsprobablynothing
  STA <songAddr
nahitsprobablynothing:
  STX <songAddrProgress
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
  .include "ifertmdrv/shortmodeaddressing.asm"


  TYA
  CLC
  ADC <songAddrProgress
  STA <songAddrProgress

ordersend:



  ; PATTERN PARSER
  ; THIS CODE IS VERY VERY GROSS, MAY GOD HELP THE SOUL OF THOSE WHO TRY TO STUDY IT

  ;LDA #$5F
  ;STA $2001

  LDX #$00
  STX channel
patternparserloop:
  LDA CHXpataddr,x
  STA <TMPpatddr
  LDA CHXpataddr+1,x
  STA <TMPpatddr+1


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


  .include "ifertmdrv/divisoraction.asm"


  LDY #$00


  .include "ifertmdrv/miniloop.asm"

  CPX #$10               ; MELODIC DPCM CODE
  BEQ skipnondpcmeffects ; MELODIC DPCM CODE

  LDA [TMPpatddr],y
  CMP #$FC
  BNE skipfcwithdelay
  INC <TMPpatddr
  LDA [TMPpatddr],y
  STA CHXbaseinst,x
  INC <TMPpatddr
skipfcwithdelay:

skipfc:




  .include "ifertmdrv/secondinsteffect.asm"

  .include "ifertmdrv/transposeeffect.asm"

  .include "ifertmdrv/finetuneeffect.asm"

  skipnondpcmeffects:

  LDA [TMPpatddr],y
  CMP #$FF
  BNE skipffwithdelay
  INY
  LDA [TMPpatddr],y
  DEY
  STA <TMPpatddr
skipffwithdelay:

skipff:





  .include "ifertmdrv/divisoreffect.asm"



  LDX channel

  LDA [TMPpatddr],y
  CMP #$FE
  BNE skipfe
  INC <TMPpatddr
  JMP skipdpcminst

skipfe:

  CPX #$10
  BEQ skipinstloopfordpcm

  LDA #$00
  STA CHXinstdelay,x
  LDA CHXbasefinetune,x
  STA CHXfinetune,x

  LDA [TMPpatddr],y

  .include "ifertmdrv/transposeaction.asm"

  AND #$FE
  STA CHXnote,x

  .include "ifertmdrv/secondinstaction.asm"


  LDA CHXbaseinst,x
  CMP #$FF
  BNE instisreatined
  LDA [TMPpatddr],y
  STA CHXinstaddr,x


  INC <TMPpatddr
  JMP skipdpcminst
instisreatined:
  LDA CHXbaseinst,x
  STA CHXinstaddr,x

instisimmediate:
  JMP skipdpcminst
skipinstloopfordpcm:
  LDA [TMPpatddr],y
  STA DPCMready
  INC <TMPpatddr
skipdpcminst:



  .include "ifertmdrv/sequencebreak.asm"



patternend:

  LDY #$00
  LDA <TMPpatddr
  STA CHXpataddr,x
  LDA <TMPpatddr+1
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
  STA APUregbuffer,x
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
  CPX #$10
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
  STA APUregbuffer+2,y
  INX
  LDA freqtbl,x
  STA APUregbuffer+3,y



  .include "ifertmdrv/finetuneaction.asm"






  INY
  INY
  INY
  INY
  CPY #$10
  BNE notewriteloop





  ;LDA #$3F
  ;STA $2001

  ; AUDIO BUFFER WRITE

  LDA APUregbuffer+8
  AND #$0F
  STA APUregbuffer+8










  LDX #$00
audioloop:

  LDA CHXmutetimer,x
  BEQ dontdecrementmute
  DEC CHXmutetimer,x
  JMP ignorebufferwrite
dontdecrementmute:

audiosubloop:
  LDA APUregbuffer,x
  STA $4000,x
  INX
  TXA
  AND #$03
  CMP #$03
  BNE audiosubloop
  LDA APUregbuffer,x
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



  LDA APUregbuffer+$B
  STA $400B


  ; AUDIO BUFFER WRITE FINISH

  .include "ifertmdrv/melodicdpcmhandler.asm"


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; IFEWARE'S REALTIME AUDIO DRIVER TM END
