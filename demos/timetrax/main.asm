.segment "HEADER"

INES_MAPPER = 0
INES_MIRROR = 0
INES_SRAM   = 0

.byte 'N', 'E', 'S', $1A
.byte $02
.byte $01
.byte INES_MIRROR | (INES_SRAM << 1) | ((INES_MAPPER & $f) << 4)
.byte (INES_MAPPER & %11110000)
.byte $0, $0, $0, $0, $0, $0, $0, $0

;;;;;;;;;;;;;;;

  .include "ifertmdrv/variables.asm"
  .include "ifertmdrv/common_modules/songformatvariables.asm"
  .segment "OAM"

;;;;;;;;;;;;;;;

  .segment "CODE"
RESET:
  SEI
  CLD
  LDX #$40
  STX $4017
  LDX #$FF
  TXS
  INX
  STX $2000
  STX $2001
  LDX #$00
  STX $4010
  BIT $2002
vblankwait1:
  BIT $2002
  BPL vblankwait1

clrmem:
  LDA #$00
  STA $0000, x
  STA $0100, x
  STA $0200, x
  STA $0300, x
  STA $0400, x
  STA $0500, x
  STA $0600, x
  STA $0700, x
  INX
  BNE clrmem


  LDA #$0F
  STA $4015

vblankwait2:
  BIT $2002
  BPL vblankwait2



	ldx #0
	ldy #0
vwait1:
	bit $2002
	bpl vwait1
vwait2:
	inx
	bne noincy
	iny
noincy:
	bit $2002
	bpl vwait2

	tya
	cmp #16
	bcc nodiv2
	lsr
nodiv2:
	clc
	adc #<-9
	cmp #3
	bcc noclip3
	lda #3
noclip3:
  STA <Region


  LDX #$20
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006
  LDY #$00
  bgloop:
  STA $2007
  INY
  BNE bgloop
  DEX
  BNE bgloop



  LDA #$3F
  STA $2006
  LDA #$00
  STA $2006
palloop:
  LDA #$1F
  STA $2007
  DEX
  BNE palloop

  LDA #$3F
  STA $2006
  LDA #$01
  STA $2006
  LDA #$2c
  STA $2007
  LDA #$3c
  STA $2007
  LDA #$30
  STA $2007




LoadBackground2:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006
  LDX #$00
  LDY #$00
LoadBackgroundLoop2:
  LDA #$00
  STA $2007
  INX
  CPX #$00
  BNE LoadBackgroundLoop2
  INY
  CPY #$08
  BNE LoadBackgroundLoop2

  LDA #$22
  STA $2006
  LDA #$0B
  STA $2006
  LDA #$08
  LDX #$09


ifelogo1:
  STA $2007
  LDA #$08
  DEX
  BNE ifelogo1

  LDA #$22
  STA $2006
  LDA #$2B
  STA $2006
  LDA #$08
  STA $2007

  LDA #$22
  STA $2006
  LDA #$4B
  STA $2006

  LDA #$08
  STA $2007
  LDA #$00
  STA $2007
  LDA #$00
  STA $2007
  LDX #$06

ifelogo2:
  LDA #$08
  STA $2007
  DEX
  BNE ifelogo2

  LDA #$22
  STA $2006
  LDA #$6B
  STA $2006
  LDA #$08
  STA $2007

  LDA #$22
  STA $2006
  LDA #$8B
  STA $2006
  LDA #$08
  STA $2007
  LDA #$22
  STA $2006
  LDA #$91
  STA $2006
  LDA #$08
  STA $2007
  LDA #$08
  STA $2007
  LDA #$08
  STA $2007

  LDA #$22
  STA $2006
  LDA #$CB
  STA $2006
  LDX #$09
rtmblockdraw:
  LDA ifertmdrvdatablock-1,x
  STA $2007
  DEX
  BNE rtmblockdraw

  LDA #$23
  STA $2006
  LDA #$0B
  STA $2006
  LDX #$09
rtmblockdraw2:
  LDA driverversionblock-1,x
  STA $2007
  DEX
  BNE rtmblockdraw2

  LDA #$20
  STA $2006
  LDA #$21
  STA $2006
  LDX #$1E
titleblockdraw:
  LDA titleblock-1,x
  STA $2007
  DEX
  BNE titleblockdraw



  LDA #$20
  STA $2006
  LDA #$61
  STA $2006
  LDX #$1E
authorblockdraw:
  LDA authorblock-1,x
  STA $2007
  DEX
  BNE authorblockdraw

  LDA #$20
  STA $2006
  LDA #$A1
  STA $2006
  LDX #$1E
driversizeblockdraw:
  LDA driversizeblock-1,x
  STA $2007
  DEX
  BNE driversizeblockdraw

  LDA #$20
  STA $2006
  LDA #$C1
  STA $2006
  LDX #$1E
songsizeblockdraw:
  LDA songsizeblock-1,x
  STA $2007
  DEX
  BNE songsizeblockdraw

  LDA #$21
  STA $2006
  LDA #$21
  STA $2006
  LDX #$1E
githubpromotionblockdraw:
  LDA githubpromotionblock-1,x
  STA $2007
  DEX
  BNE githubpromotionblockdraw


  LDA #$23
  STA $2006
  LDA #$7D
  STA $2006
  LDA #$8E
  STA $2007

  LDA #$23
  STA $2006
  LDA #$7B
  STA $2006
  LDA #$8F
  STA $2007

  LDA #$23
  STA $2006
  LDA #$79
  STA $2006
  LDA #$90
  STA $2007

  LDA #$22
  STA $2006
  LDA #$D9
  STA $2006

  LDA #$54
  STA $2007
  LDA #$69
  STA $2007
  LDA #$6D
  STA $2007
  LDA #$65
  STA $2007
  LDA #$3A
  STA $2007



  ;;;;;;;;;;;;;

  LDA <Region
  BNE palset
  LDA #60
  STA $21
  JMP ntscset
palset:
  LDA #50
  STA $21
ntscset:

  LDA #$80
  STA <$A5
  STA <$A3
  STA <$A1
  LDA #$08
  STA APUregbuffer+1
  STA APUregbuffer+5
  STA APUregbuffer+9

  LDA #>song1
  STA songAddr
  LDA #<song1
  STA songAddrProgress

  ;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  LDX #$8C
  STX $2000

Update:
  JMP *+3
  JMP Update



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NMI:

  LDA #$00
  STA $2001


  LDA #$23
  STA $2006
  LDA #$19
  STA $2006
  LDA $A4
  STA $2007

  LDA #$23
  STA $2006
  LDA #$39
  STA $2006
  LDA $AC
  STA $2007

  LDA #$23
  STA $2006
  LDA #$59
  STA $2006
  LDA $A5
  STA $2007




  LDA #$23
  STA $2006
  LDA #$1B
  STA $2006
  LDA $A2
  STA $2007

  LDA #$23
  STA $2006
  LDA #$3B
  STA $2006
  LDA $AB
  STA $2007

  LDA #$23
  STA $2006
  LDA #$5B
  STA $2006
  LDA $A3
  STA $2007





  LDA #$23
  STA $2006
  LDA #$1D
  STA $2006
  LDA $A0
  STA $2007

  LDA #$23
  STA $2006
  LDA #$3D
  STA $2006
  LDA $AA
  STA $2007

  LDA #$23
  STA $2006
  LDA #$5D
  STA $2006
  LDA $A1
  STA $2007





  tmp = $20


  LDX #$00
  STX $2001
  LDA $2002
  LDA #$00
  STA <tmp

playerloop:

  LDA #$21
  STA $2006
  LDA testbits,x
  STA $2006
  LDY #$0F



  CPX #$08
  BNE skiptri

  LDA APUregbuffer+3,x
  BNE dontmutetri
  LDA #$0F
  STA <tmp
  BPL writethingloop
dontmutetri:
  LDA APUregbuffer,x
  BNE writethingloop2
  LDA #$0F
  STA <tmp
  BPL writethingloop

skiptri:
  LDA APUregbuffer+3,x
  BNE notmute
  LDA #$0F
  STA <tmp
  BPL writethingloop




notmute:
  LDA APUregbuffer,x
  AND #$0F
  EOR #$0F
  STA <tmp
  BEQ writethingloop2


writethingloop:
  LDA #$00
  STA $2007
  DEY
  DEC <tmp
  BNE writethingloop

  TYA
  BEQ endofwritething

writethingloop2:
  LDA yvalues,y
  STA $2007
  DEY
  BNE writethingloop2
endofwritething:

  INX
  INX
  INX
  INX
  CPX #$10
  BNE playerloop







  LDA #$00
  STA $2005
  STA $2005
  LDA #$18
  STA $2001


  .include "ifertmdrv/ifertmdrv.asm"

  INC $80
  LDA $80
  CMP $21
  BCC skiptimejump
  LDA #$00
  STA $80
  INC $81
  LDA $81
  CMP #60
  BCC skiptimejump
  LDA #$00
  STA $81
  INC $82
  LDA $82
skiptimejump:

  LDA $81
  JSR genbcd
  LDA $89
  STA $92
  LDA $8A
  STA $93

  LDA $82
  JSR genbcd
  LDA $89
  STA $90
  LDA $8A
  STA $91

  LDA $80
  JSR genbcd
  LDA $89
  STA $94
  LDA $8A
  STA $95




  LDA $95
  BEQ nullouttenframe
  CLC
  ADC #$80
  STA $A5
  JMP frameend
nullouttenframe:
  LDA $94
  BNE carryonframe
  LDA #$80
  STA $A5
  JMP frameend
carryonframe:
  LDA #$00
  STA $A5
frameend:

  LDA $94
  CMP #$02
  BCC frametensskip
  CLC
  ADC #$80
  STA $A4
  LDA #10+$80
  STA $AC
  JMP framenottensskip
frametensskip:
  LDA #$00
  STA $A4
  LDA #$00
  STA $AC
  LDA $94
  BEQ framenottensskip
  LDA #10+$80
  STA $AC
framenottensskip:





  LDA $93
  BEQ nullouttensecond
  CLC
  ADC #$80
  STA $A3
  JMP secondend
nullouttensecond:
  LDA $92
  BNE carryonsecond
  LDA #$80
  STA $A3
  JMP secondend
carryonsecond:
  LDA #$00
  STA $A3
secondend:

  LDA $92
  CMP #$02
  BCC secondtensskip
  CLC
  ADC #$80
  STA $A2
  LDA #10+$80
  STA $AB
  JMP secondnottensskip
secondtensskip:
  LDA #$00
  STA $A2
  LDA #$00
  STA $AB
  LDA $92
  BEQ secondnottensskip
  LDA #10+$80
  STA $AB
secondnottensskip:







  LDA $91
  BEQ nullouttenminute
  CLC
  ADC #$80
  STA $A1
  JMP minuteend
nullouttenminute:
  LDA $90
  BNE carryonminute
  LDA #$80
  STA $A1
  JMP minuteend
carryonminute:
  LDA #$00
  STA $A1
minuteend:

  LDA $90
  CMP #$02
  BCC minutetensskip
  CLC
  ADC #$80
  STA $A0
  LDA #10+$80
  STA $AA
  JMP minutenottensskip
minutetensskip:
  LDA #$00
  STA $A0
  LDA #$00
  STA $AA
  LDA $90
  BEQ minutenottensskip
  LDA #10+$80
  STA $AA
minutenottensskip:



  RTI
  .include "genbcd.asm"

ifertmdrvdatablock:
  .byte "vrdmtrEFI"
driverversionblock:
  .byte " 0.6.1v  "
titleblock:
  .byte "      eltiT - xarT emiT :eltiT"
authorblock:
  .byte "                nilloF miT :yB"
driversizeblock:
  .byte "       setyB 9411 :eziS revirD"
songsizeblock:
  .byte "       setyB 259    :eziS gnoS"
githubpromotionblock:
  .byte " vrdmtrEFI/erawEFI/moc.buhtig "

testbits:
  .byte $C1,$00,$00,$00,$C3,$00,$00,$00,$C5,$00,$00,$00,$C7,$00,$00,$00

yvalues:
  .byte $07,$07,$07,$07,$07,$07,$07,$06,$06,$06,$06,$06,$05,$05,$05,$05



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  .align 256
speedtbl:
  .include "speedtbl.asm"
freqtbl:
  .incbin "freqtbl.db"
instrument:
  .include "instrument.asm"
song1:
  .include "centralmusic.asm"





;;;;;;;;;;;;;;

  .segment "REGION"
  .byte "REGION:"

  .segment "VECTORS"
  .word NMI
  .word RESET
  .word 0
;;;;;;;;;;;;;;

  .segment "TILES"
  .incbin "main.chr"
