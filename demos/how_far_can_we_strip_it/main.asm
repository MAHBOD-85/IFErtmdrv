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

  .include "ifertmdrv/variables.asm"

;;;;;;;;;;;;;;;

  .segment "CODE"
RESET:
  BIT $2002
vblankwait1:       ; First wait for vblank to make sure PPU is ready
  BIT $2002
  BPL vblankwait1
  TXA
clrmem:
  STA $00, x
  INX
  BNE clrmem

  ;;;;;;;;;;;;;; LOAD FUNCTION

  LDA #$AD
  STA CHXpataddr
  LDA #$63
  STA CHXpataddr+4
  LDA #$7B
  STA CHXpataddr+8
  LDA #$6F
  STA CHXpataddr+12

  ;;;;;;;;;;;;;; FINISH LOAD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  LDA #$FF
  STA $2000    ; enable NMI
  STA $4015
  STA TMPpatddr+1

Update:
  BMI Update

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NMI:
  .include "ifertmdrv/ifertmdrv.asm"
  RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
freqtbl:
  .incbin "newfreqtable.db"
instrument:
  .incbin "instrument.db"
instrument2:
  .incbin "instrument2.db"
song1:
  .incbin "song1.db"


;;;;;;;;;;;;;;

  .segment "VECTORS"
  .word NMI
  .word RESET
  .word 0
;;;;;;;;;;;;;;

  .segment "TILES"
