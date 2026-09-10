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

  JSR zsaw_init

  CLI
  LDA #$1F
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
  LDA #$3F
  STA $2006
  LDA #$00
  STA $2006
palloop:
  LDA #$1F
  STA $2007
  DEX
  BNE palloop

  ;;;;;;;;;;;;;

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

  LDX #$88
  STX $2000

Update:
  JMP Update



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ZSAW_NMI_GAME_HANDLER:
  .include "ifertmdrv/ifertmdrv.asm"
  RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

speedtbl:
  .include "speedtbl.asm"
freqtbl:
  .incbin "freqtbl.db"
instrument:
  .include "instrument.asm"
song1:
  .include "centralmusic.asm"

.segment "DPCM"

  .include "ifertmdrv/zsaw_ca65_module/zsaw.inc"
  .include "ifertmdrv/zsaw_ca65_module/zsaw.asm"

  .align 64
dpcm1:
  .incbin "dpcm.dmc"
  .align 64
dpcm2:

dpcmtbl:
  .include "dpcmtbl.asm"


;;;;;;;;;;;;;;

  .segment "VECTORS"
  .word zsaw_nmi
  .word RESET
  .word zsaw_irq
;;;;;;;;;;;;;;

  .segment "TILES"
