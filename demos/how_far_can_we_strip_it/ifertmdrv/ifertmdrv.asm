









  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; IFEWARE'S REALTIME AUDIO DRIVER TM BEGIN

  ; ORDERS TIMER





  ; PATTERN PARSER
  ; THIS CODE IS VERY VERY GROSS, MAY GOD HELP THE SOUL OF THOSE WHO TRY TO STUDY IT

  ;LDA #$5F
  ;STA $2001

  STX channel
patternparserloop:
  LDA CHXpataddr,x
  STA <TMPpatddr
  LDA CHXframetimer,x
  DEC CHXframetimer,x
  CMP #$00
  BNE instloop
  LDA #$08
  STA CHXframetimer,x

skipresetchannelspeed:
skipthisthingtootwo:

  LDA CHXdivisorcount,x
  BEQ goon
  SBC #$20
  STA CHXdivisorcount,x
  JMP instloop
goon:

  LDY #$00

  .include "ifertmdrv/miniloop.asm"


  LDA (TMPpatddr),y
  CMP #$FF
  BNE skipffwithdelay
  INC <TMPpatddr
  LDA (TMPpatddr),y
  STA <TMPpatddr
skipffwithdelay:

skipff:


  TYA
effectloop:
  CLC
  ADC #$FA
  CMP (TMPpatddr),y
  BNE skipfd
  INC <TMPpatddr
  LDA (TMPpatddr),y
  STA CHXframetimer,x
  INC <TMPpatddr
skipfd:
  INX
  TXA
  AND #$03
  BNE effectloop
skipfdwithdelay:
  LDX channel















skipfe:
  LDA (TMPpatddr),y
  AND #$E0
  BEQ npn
  STA CHXdivisorcount,x
npn:
  LDA (TMPpatddr),y
  AND #$1E
  STA CHXnote,x

  .include "ifertmdrv/secondinstaction.asm"



instisreatined:
  LDA CHXbaseinst,x
  STA CHXinstaddr,x

instisimmediate:





instloop:
  LDA <TMPpatddr
  STA CHXpataddr,x


ignoredelay:



  LDY CHXinstaddr,x
  LDA instrument,y
  CMP #$C0
  BNE notspecialbytewithdelay
specialbyte:
  LDA instrument2,y
  STA CHXinstaddr,x
  TAY
  LDA instrument,y

notspecialbytewithdelay:






notspecialbyte:
  STA $4000,x
instnop:

  LDA instrument2,y
  CLC
  ADC CHXnote,x
  STA CHXnote,x
  INC CHXinstaddr,x

instdelay:






notewriteloop:
  LDY CHXnote,x
  TYA
  CMP CHXtranspose,x
  BEQ bufferwritten
  STY CHXtranspose,x
  LDA freqtbl,y
  STA $4000+2,x
  LDA freqtbl+1,y
  STA $4000+3,x
bufferwritten:
















patternend:
  INX
  INX
  INX
  INX
  STX channel
  CPX #$10
  BEQ patternendforrealz
  JMP patternparserloop
patternendforrealz:
  LDX #$00



  ; GROSS CODE FINISHED #############################################



  ; INSTRUMENT LOOP


  ;LDA #$1B
  ;STA $2001















  ;LDA #$3F
  ;STA $2001

  ; AUDIO BUFFER WRITE
















  ; AUDIO BUFFER WRITE FINISH


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; IFEWARE'S REALTIME AUDIO DRIVER TM END
