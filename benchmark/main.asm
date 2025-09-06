  .inesprg 2   ; 1x 32KB PRG code
  .ineschr 1   ; 1x  8KB CHR data
  .inesmap 0   ; mapper 0 = NROM, no bank swapping
  .inesmir 1   ; background mirroring

;;;;;;;;;;;;;;;

  .include "ifertmdrv/variables.asm"

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
  STA $0000, x
  STA $0100, x
  STA $0300, x
  STA $0400, x
  STA $0500, x
  STA $0600, x
  STA $0700, x
  INX
  BNE clrmem

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

  LDA #$A0
  STA songAddr

  LDA #$0F
  STA $4015

  ;;;;;;;;;;;;;; FINISH LOAD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  LDA #$00
  STA <$FF
  LDX #$88
  STX $2000    ; enable NMI

vblankwait15:
  BIT $2002
  BPL vblankwait15
  LDA #$00
  STA $FF      ; prevent the shitass race condition

Update:
  JMP Update

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  .bank 0
  .org $9000
NMI:
  .include "ifertmdrv/ifertmdrv.asm"
  LDX #$1A
  STX $2001    ; enable rendering
  RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  .bank 1
  .org $A000
song1:
  .incbin "song1.db"


  .bank 2
  .org $C000
  .incbin "ripped00.dmc"
  .org $C400
  .incbin "ripped01.dmc"
  .org $C800
  .incbin "ripped02.dmc"
  .org $CC00
  .incbin "ripped03.dmc"
  .org $D000
  .incbin "ripped04.dmc"
  .org $D400
dpcmtbl:
  .incbin "dpcmtbl.db"


  .bank 3
  .org $FC00
speedtbl:
  .incbin "speedtbl.db"
  .org $FF00
freqtbl:
  .incbin "freqtbl.db"
  .org $FD00
instrument:
  .incbin "instrument.db"
  .org $FE00
instrument2:
  .incbin "instrument2.db"

;;;;;;;;;;;;;;

  .bank 3
  .org $FFFA     ;first of the three vectors starts here
  .dw NMI        ;when an NMI happens (once per frame if enabled) the
                   ;processor will jump to the label NMI:
  .dw RESET      ;when the processor first turns on or is reset, it will jump
                   ;to the label RESET:
  .dw 0          ;external interrupt IRQ is not used in this tutorial

;;;;;;;;;;;;;;

  .bank 4
  .org $0000
