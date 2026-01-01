.segment "HEADER"

INES_MAPPER = 0 ; 0 = NROM
INES_MIRROR = 0 ; 0 = horizontal mirroring, 1 = vertical mirroring
INES_SRAM   = 0 ; 1 = battery backed SRAM at $6000-7FFF

.byte 'N', 'E', 'S', $1A ; ID
.byte $02 ; 16k PRG chunk count
.byte $01 ; 8k CHR chunk count
.byte INES_MIRROR | (INES_SRAM << 1) | ((INES_MAPPER & $f) << 4)
.byte (INES_MAPPER & %11110000)
.byte $0, $0, $0, $0, $0, $0, $0, $0 ; padding

;;;;;;;;;;;;;;;

  .include "version_z/ifertmdrv/variables.asm"
  .include "ifertmdrv/common_modules/songformatvariables.asm"
  .segment "OAM"

;;;;;;;;;;;;;;;

  .segment "CODE"
RESET:
  SEI          ; disable IRQs
  CLD          ; disable decimal mode
  LDX #$40
  STX $4017    ; disable APU frame IRQ
  LDX #$FF
  TXS          ; Set up stack
  INX          ; now X = 0
  STX $2000    ; disable NMI
  STX $2001    ; disable rendering
  LDX #$00
  STX $4010    ; disable DMC IRQs
  BIT $2002
vblankwait1:       ; First wait for vblank to make sure PPU is ready
  BIT $2002
  BPL vblankwait1

clrmem:
  LDA #$00
  STA $0000, x
  STA $0100, x
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

vblankwait2:      ; Second wait for vblank, PPU is ready after this
  BIT $2002
  BPL vblankwait2

                        ; PRERENDER FUNCTION
  LDX #$20
  LDA #$3F
  STA $2006             ; SETUP PALETTE
  LDA #$00
  STA $2006
palloop:
  LDA #$1F
  STA $2007
  DEX
  BNE palloop

  ;;;;;;;;;;;;;; LOAD FUNCTION

  LDA #$80
  STA <$06
  LDA #$08
  STA APUregbuffer+1
  STA APUregbuffer+5
  STA APUregbuffer+9

  LDA #>song1
  STA songAddr


  ;;;;;;;;;;;;;; FINISH LOAD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  LDX #$88
  STX $2000    ; enable NMI

Update:
  JMP Update



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ZSAW_NMI_GAME_HANDLER:
  .include "version_z/ifertmdrv/ifertmdrv.asm"
  RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  .align 256
speedtbl:
  .incbin "speedtbl.db"
freqtbl:
  .incbin "freqtbl.db"
instrument:
  .incbin "instrument.db"
instrument2:
  .incbin "instrument2.db"
song1:
  .include "centralmusicz.asm"

.segment "DPCM"

  .include "version_z/ifertmdrv/zsaw_ca65_module/zsaw.inc"
  .include "version_z/ifertmdrv/zsaw_ca65_module/zsaw.asm"

dpcmtbl:
  .incbin "dpcmtbl.db"



;;;;;;;;;;;;;;

  .segment "VECTORS"
  .word zsaw_nmi
  .word RESET
  .word zsaw_irq
;;;;;;;;;;;;;;

  .segment "TILES"
