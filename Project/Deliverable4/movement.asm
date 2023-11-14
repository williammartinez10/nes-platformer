.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_x: .res 1 ; ---------------------- for referencing an x coordinate
player_y: .res 1 ; ---------------------- for referencing a y coordinate
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
    ; ----------------------------------- write a palette
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


	; ----------------------------------- background -> done with just one loop by using two registers and low/high bytes
load_background:
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$00
	STA PPUADDR

	LDA #<canvas ; ---------------------- load least significant byte from background graphic layout
	STA LOWBYTE                        
	LDA #>canvas ; ---------------------- load most significant byte from background graphic layout
	STA HIGHBYTE
	LDX #$00                         
	LDY #$00
@load_background_loop:
	LDA (LOWBYTE), Y ; ---------------------- (indirect),Y => go over low bytes
	STA PPUDATA
	INY
	CPY #$00
	BNE @load_background_loop
	INC HIGHBYTE ; ---------------------- increment memory by one
	INX
	CPX #$04
	BNE @load_background_loop


vblankwait: ; --------------------------- wait for another vblank before continuing
    BIT PPUSTATUS
    BPL vblankwait
    LDA #%10010000 ; -------------------- turn on NMIs, sprites use first pattern table
    STA PPUCTRL
    LDA #%00011110 ; -------------------- turn on screen
    STA PPUMASK

forever:
    ; ----------------------------------- infinite loop helps maintain the animation for a long time
    JSR draw_player_walking1 ; ---------- walking animation - sprite 1
    JSR draw_player_walking2 ; ---------- walking animation - sprite 2
    JSR draw_player_walking3 ; ---------- walking animation - sprite 3

    JMP forever
.endproc


.proc draw_player_walking1
    ; ----------------------------------- keep track of state of the registers on the stack
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA

    ; ----------------------------------- write player tiles to be used for this frame
    LDA #$11
    STA $0201
    LDA #$12
    STA $0205
    LDA #$43
    STA $0209
    LDA #$44
    STA $020d

    ; ----------------------------------- player tile attributes, including corresponding palette
    LDA #$00
    STA $0202
    STA $0206
    STA $020a
    STA $020e

    ; ----------------------------------- store tile locations
    ; ----------------------------------- top left tile:
    LDA player_y
    STA $0200
    LDA player_x
    STA $0203

    ; ----------------------------------- top right tile (x + 8):
    LDA player_y
    STA $0204
    LDA player_x
    CLC
    ADC #$08
    STA $0207

    ; ----------------------------------- bottom left tile (y + 8):
    LDA player_y
    CLC
    ADC #$08
    STA $0208
    LDA player_x
    STA $020b

    ; ----------------------------------- bottom right tile (x + 8, y + 8)
    LDA player_y
    CLC
    ADC #$08
    STA $020c
    LDA player_x
    CLC
    ADC #$08
    STA $020f

    LDA #%00000000 ; -------------------- helps make frame transitiones smoother by setting all bits to 0

    ; ----------------------------------- reverse everything that was stored at the beginning, in opposite order
    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTS
.endproc

.proc draw_player_walking2
    ; ----------------------------------- keep track of state of the registers on the stack
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA

    ; ----------------------------------- write player tiles to be used for this frame
    LDA #$11
    STA $0201
    LDA #$12
    STA $0205
    LDA #$45
    STA $0209
    LDA #$46
    STA $020d

    ; ----------------------------------- player tile attributes, including corresponding palette
    LDA #$00
    STA $0202
    STA $0206
    STA $020a
    STA $020e

    ; ----------------------------------- store tile locations
    ; ----------------------------------- top left tile:
    LDA player_y
    STA $0200
    LDA player_x
    STA $0203

    ; ----------------------------------- top right tile (x + 8):
    LDA player_y
    STA $0204
    LDA player_x
    CLC
    ADC #$08
    STA $0207

    ; ----------------------------------- bottom left tile (y + 8):
    LDA player_y
    CLC
    ADC #$08
    STA $0208
    LDA player_x
    STA $020b

    ; ----------------------------------- bottom right tile (x + 8, y + 8)
    LDA player_y
    CLC
    ADC #$08
    STA $020c
    LDA player_x
    CLC
    ADC #$08
    STA $020f

    LDA #%00000000 ; -------------------- helps make frame transitiones smoother by setting all bits to 0

    ; ----------------------------------- reverse everything that was stored at the beginning, in opposite order
    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTS
.endproc

.proc draw_player_walking3
    ; ----------------------------------- keep track of state of the registers on the stack
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA

    ; ----------------------------------- write player tiles to be used for this frame
    LDA #$11
    STA $0201
    LDA #$12
    STA $0205
    LDA #$2c
    STA $0209
    LDA #$2d
    STA $020d 

    ; ----------------------------------- player tile attributes, including corresponding palette
    LDA #$00
    STA $0202
    STA $0206
    STA $020a
    STA $020e

    ; ----------------------------------- store tile locations
    ; ----------------------------------- top left tile:
    LDA player_y
    STA $0200
    LDA player_x
    STA $0203

    ; ----------------------------------- top right tile (x + 8):
    LDA player_y
    STA $0204
    LDA player_x
    CLC
    ADC #$08
    STA $0207

    ; ----------------------------------- bottom left tile (y + 8):
    LDA player_y
    CLC
    ADC #$08
    STA $0208
    LDA player_x
    STA $020b

    ; ----------------------------------- bottom right tile (x + 8, y + 8)
    LDA player_y
    CLC
    ADC #$08
    STA $020c
    LDA player_x
    CLC
    ADC #$08
    STA $020f

    LDA #%00000000 ; -------------------- helps make frame transitiones smoother by setting all bits to 0

    ; ----------------------------------- reverse everything that was stored at the beginning, in opposite order
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
    ; ----------------------------------- background
    .byte $0f, $3d, $30, $3c
    .byte $0f, $01, $21, $31
    .byte $0f, $06, $16, $26
    .byte $0f, $09, $19, $29

    ; ----------------------------------- sprites
    .byte $0f, $18, $16, $29
    .byte $0f, $3d, $30, $3c
    .byte $0f, $19, $09, $29
    .byte $0f, $19, $09, $29


.include "canvas.asm" ; ----------------- background graphic layout


.segment "CHR"
.incbin "movement.chr"
