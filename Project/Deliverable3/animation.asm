.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_x: .res 1
player_y: .res 1
.exportzp player_x, player_y

.segment "CODE"
.proc irq_handler
    RTI
.endproc

.proc nmi_handler
    LDA #$00
    STA OAMADDR
    LDA #$02
    STA OAMDMA
	LDA #$00
	STA $2005
	STA $2005
    RTI
.endproc

.import reset_handler

.export main
.proc main
    ; write a palette
load_palettes:
    LDX PPUSTATUS
    LDX #$3f
    STX PPUADDR
    LDX #$01
    STX PPUADDR
@load_palettes_loop:
    LDA palettes,X
    STA PPUDATA
    INX
    CPX #$20
    BNE @load_palettes_loop

vblankwait: ; ----------------------------- wait for another vblank before continuing
    BIT PPUSTATUS
    BPL vblankwait
    LDA #%10010000 ; ---------------------- turn on NMIs, sprites use first pattern table
    STA PPUCTRL
    LDA #%00011110 ; ---------------------- turn on screen
    STA PPUMASK

forever:
    JSR draw_player_walking1
    JSR draw_player_walking2
    JSR draw_player_walking3

    JMP forever
.endproc


.proc draw_player_walking1
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA

    LDA #$11
    STA $0201
    LDA #$12
    STA $0205
    LDA #$43
    STA $0209
    LDA #$44
    STA $020d

    LDA #$00
    STA $0202
    STA $0206
    STA $020a
    STA $020e

    ; store tile locations
    ; top left tile:
    LDA player_y
    STA $0200
    LDA player_x
    STA $0203

    ; top right tile (x + 8):
    LDA player_y
    STA $0204
    LDA player_x
    CLC
    ADC #$08
    STA $0207

    ; bottom left tile (y + 8):
    LDA player_y
    CLC
    ADC #$08
    STA $0208
    LDA player_x
    STA $020b

    ; bottom right tile (x + 8, y + 8)
    LDA player_y
    CLC
    ADC #$08
    STA $020c
    LDA player_x
    CLC
    ADC #$08
    STA $020f

    LDA #%00000000

    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTS
.endproc

.proc draw_player_walking2
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA

    LDA #$11
    STA $0201
    LDA #$12
    STA $0205
    LDA #$45
    STA $0209
    LDA #$46
    STA $020d

    LDA #$00
    STA $0202
    STA $0206
    STA $020a
    STA $020e

    ; store tile locations
    ; top left tile:
    LDA player_y
    STA $0200
    LDA player_x
    STA $0203

    ; top right tile (x + 8):
    LDA player_y
    STA $0204
    LDA player_x
    CLC
    ADC #$08
    STA $0207

    ; bottom left tile (y + 8):
    LDA player_y
    CLC
    ADC #$08
    STA $0208
    LDA player_x
    STA $020b

    ; bottom right tile (x + 8, y + 8)
    LDA player_y
    CLC
    ADC #$08
    STA $020c
    LDA player_x
    CLC
    ADC #$08
    STA $020f

    LDA #%00000000

    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTS
.endproc

.proc draw_player_walking3
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA

    LDA #$11
    STA $0201
    LDA #$12
    STA $0205
    LDA #$2c
    STA $0209
    LDA #$2d
    STA $020d

    LDA #$00
    STA $0202
    STA $0206
    STA $020a
    STA $020e

    ; store tile locations
    ; top left tile:
    LDA player_y
    STA $0200
    LDA player_x
    STA $0203

    ; top right tile (x + 8):
    LDA player_y
    STA $0204
    LDA player_x
    CLC
    ADC #$08
    STA $0207

    ; bottom left tile (y + 8):
    LDA player_y
    CLC
    ADC #$08
    STA $0208
    LDA player_x
    STA $020b

    ; bottom right tile (x + 8, y + 8)
    LDA player_y
    CLC
    ADC #$08
    STA $020c
    LDA player_x
    CLC
    ADC #$08
    STA $020f

    LDA #%00000000

    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTS
.endproc


.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler


.segment "RODATA"
palettes:
    ; background
    .byte $0f, $3d, $30, $3c
    .byte $0f, $01, $21, $31
    .byte $0f, $06, $16, $26
    .byte $0f, $09, $19, $29

    ; sprites
    .byte $0f, $18, $16, $29
    .byte $0f, $3d, $30, $3c
    .byte $0f, $19, $09, $29
    .byte $0f, $19, $09, $29


.segment "CHR"
.incbin "animation.chr"
