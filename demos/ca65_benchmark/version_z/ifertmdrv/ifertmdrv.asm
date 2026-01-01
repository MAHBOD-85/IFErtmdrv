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
  LDA (songAddrProgress),y
  CMP #$20
  BNE ordersnotjmp

  INY
  LDA (songAddrProgress),y
  TAX
  INY
  LDA (songAddrProgress),y
  STX <songAddrProgress
  STA <songAddr
  DEY
  DEY
ordersnotjmp:

  LDA (songAddrProgress),y
  CMP #$10
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
  LDA patternSpeedX
  STA currentPatternFrameTimer
  LDX #$00

ordersetloop:
  .include "version_z/ifertmdrv/exclusive_modules/longmodeaddressing.asm"

  TYA
  CLC
  ADC <songAddrProgress
  STA <songAddrProgress

ordersend:
  LDX #$00
  STX channel

patternparserloop:
  LDA CHXpataddr,x
  STA <TMPpataddr
  LDA CHXpataddr+1,x
  STA <TMPpataddr+1
  LDY #$00
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
  BCS skipthisthingtootwo

skipresetchannelspeed:
  JMP patternend

skipthisthingtootwo:

  .include "ifertmdrv/common_modules/divisoraction.asm"

  LDY #$00

  .include "ifertmdrv/common_modules/miniloop.asm"

  LDA (TMPpataddr),y
  CMP #$FC
  BNE skipfc

  INY
  LDA (TMPpataddr),y
  STA CHXbaseinst,x
  INY
skipfc:

  .include "ifertmdrv/common_modules/secondinsteffect.asm"

  .include "ifertmdrv/common_modules/transposeeffect.asm"

  .include "ifertmdrv/common_modules/finetuneeffect.asm"

  .include "ifertmdrv/common_modules/divisoreffect.asm"

  STY ExtraReg

  LDA (TMPpataddr),y
  CMP #$FF
  BNE skipff

  INY
  LDA (TMPpataddr),y
  BMI minusffjump

  ADC ExtraReg
  CLC
  ADC <TMPpataddr
  STA <TMPpataddr
  LDA #$00
  TAY
  ADC <TMPpataddr+1
  STA <TMPpataddr+1
  JMP skipff

minusffjump:
  ADC ExtraReg
  CLC
  ADC <TMPpataddr
  STA <TMPpataddr
  LDA <TMPpataddr+1
  ADC #$FF
  STA <TMPpataddr+1
  LDY #$00

skipff:
  LDX channel
  LDA (TMPpataddr),y
  CMP #$FE
  BEQ instisimmediate

  LDA #$00
  STA CHXinstdelay,x
  LDA CHXbasefinetune,x
  STA CHXfinetune,x
  LDA (TMPpataddr),y

  .include "ifertmdrv/common_modules/transposeaction.asm"

  AND #$FE
  STA CHXnote,x

  .include "ifertmdrv/common_modules/secondinstaction.asm"

  LDA CHXbaseinst,x
  CMP #$FF
  BNE instisretained

  INY
  LDA (TMPpataddr),y

instisretained:
  STA CHXinstaddr,x

instisimmediate:
  INY

  .include "ifertmdrv/common_modules/sequencebreak.asm"

patternend:

  TYA
  CLC
  ADC <TMPpataddr
  STA CHXpataddr,x
  LDA #$00
  ADC <TMPpataddr+1
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



  ; INSTRUMENT LOOP



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
  BNE notspecialbyte

specialbyte:
  LDA instrument2,y
  STA CHXinstaddr,x
  TAY
  LDA instrument,y

notspecialbyte:
  CMP #$E0
  BEQ instnop

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
  BNE ignoreinstdelay

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
  STA APUregbuffer+2,y
  LDA freqtbl+1,x
  STA APUregbuffer+3,y

  .include "ifertmdrv/common_modules/finetuneaction.asm"

  INY
  INY
  INY
  INY
  CPY #$10
  BNE notewriteloop



  ; ZSAW CODE



  LDA APUregbuffer + $10
  AND #$3F
  JSR zsaw_set_volume
  LDA APUregbuffer + $10
  LSR a
  LSR a
  LSR a
  LSR a
  LSR a
  AND #$06
  JSR zsaw_set_timbre
  LDA CHXnote + $10
  LSR a
  CLC
  ADC #$fe
  JSR zsaw_play_note ; enables DMC IRQ


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



  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; IFEWARE'S REALTIME AUDIO DRIVER TM END
