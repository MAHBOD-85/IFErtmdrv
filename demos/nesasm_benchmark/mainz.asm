  .inesprg 2   ; 1x 32KB PRG code
  .ineschr 1   ; 1x  8KB CHR data
  .inesmap 0   ; mapper 0 = NROM, no bank swapping
  .inesmir 1   ; background mirroring

;;;;;;;;;;;;;;;

  .include "version_z/ifertmdrv/variables.asm"
  .include "ifertmdrv/common_modules/songformatvariables.asm"

;;;;;;;;;;;;;;;

  .bank 0
  .org $8000
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
  STA $00, x
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

  LDA #HIGH(song1)
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




  .bank 1
  .org $A000
song1:
  .include "centralmusicz.asm"


  .bank 2
  .org $C000

  .include "version_z/ifertmdrv/zsaw_nesasm_module/zsaw.inc"
  .include "version_z/ifertmdrv/zsaw_nesasm_module/zsaw.asm"

  .bank 3
  .org $EC00
speedtbl:
  .incbin "speedtbl.db"
  .org $EF00
freqtbl:
  .incbin "freqtbl.db"
  .org $ED00
instrument:
  .incbin "instrument.db"
  .org $EE00
instrument2:
  .incbin "instrument2.db"






;;;;;;;;;;;;;;

  .bank 3
  .org $FFFA
  .dw zsaw_nmi
  .dw RESET
  .dw zsaw_irq

;;;;;;;;;;;;;;

  .bank 4
  .org $0000

