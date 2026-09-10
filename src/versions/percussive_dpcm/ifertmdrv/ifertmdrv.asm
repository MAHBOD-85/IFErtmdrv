  ; ORDERS TIMER



  .include "ifertmdrv/common_modules/orderstimer.asm"



  ; ORDERS PARSER



  .include "ifertmdrv/common_modules/ordersjump.asm"

  .include "ifertmdrv/common_modules/ordersheader.asm"

  .include "ifertmdrv/common_modules/instbankset.asm"

  LDA patternSpeedX
  STA currentPatternFrameTimer
  LDX #$00

ordersetloop:
  .include "ifertmdrv/common_modules/longmodeaddressing.asm"

  TYA
  CLC
  ADC <songAddrProgress
  STA <songAddrProgress
  BCC ordersend
  INC <songAddr

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

  .include "ifertmdrv/common_modules/patternjump.asm"

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

  .include "ifertmdrv/exclusive_modules/percussivedpcminstrument.asm"

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
  CPX #$10
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
  LDA (instBank),y
  STA ExtraReg
  CMP #$C0
  BNE notspecialbyte

specialbyte:
  LDA CHXinstaddr,x
  INY
  SBC (instBank),y
  TAY
  LDA (instBank),y
  STA ExtraReg
notspecialbyte:
  AND #$3F
  CMP #$30
  BEQ instnop
  LDA ExtraReg
  AND #$0F
  STA APUregbuffer,x
  LDA ExtraReg
  AND #$30
  ASL a
  ASL a
  ORA #$30
  ORA APUregbuffer,x
  STA APUregbuffer,x


instnop:
  INY
  BIT ExtraReg
  BVC instdelay

  LDA (instBank),y
  AND #$01
  BNE instsetfinetune

  LDA (instBank),y
  CLC
  ADC CHXnote,x
  STA CHXnote,x
  INY
  JMP instdelay

instsetfinetune:
  LDA (instBank),y
  AND #$FE
  CLC
  ADC CHXfinetune,x
  STA CHXfinetune,x
  INY

instdelay:
  BIT ExtraReg
  BPL ignoreinstdelay

  LDA (instBank),y
  INY
  STY ExtraReg
  LDY <Region
  BEQ skipspeedcorrect2
  CLC
  ADC #palspeedtbl-speedtbl
skipspeedcorrect2:
  TAY
  LDA speedtbl,y
  STA CHXinstdelay,x
  LDY ExtraReg
ignoreinstdelay:
  TYA
  STA CHXinstaddr,x
instloopskip:

notewriteloop:
  LDY CHXnote,x
  LDA <Region
  CMP #$01
  BNE skippitchcorrect

  CPX #$0C
  BEQ skippitchcorrect

  INY
  INY
skippitchcorrect:

  LDA freqtbl,y
  STA APUregbuffer+2,x
  LDA freqtbl+1,y
  STA APUregbuffer+3,x

  .include "ifertmdrv/common_modules/finetuneaction.asm"

  INX
  INX
  INX
  INX
  CPX #$10
  BEQ instloopend
  JMP instloop

instloopend:



  ; AUDIO BUFFER WRITE



  .include "ifertmdrv/common_modules/apubufferloop.asm"



  ; AUDIO BUFFER WRITE FINISH



  .include "ifertmdrv/exclusive_modules/percussivedpcmhandler.asm"
