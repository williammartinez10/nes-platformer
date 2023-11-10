.include "constants.inc"
.include "header.inc"

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
@load_palette_loop:
    LDA palettes,X
    STA PPUDATA
    INX
    CPX #$20
    BNE @load_palette_loop


	; background -> done with just one loop by using two registers and low/high bytes
load_background:
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$00
	STA PPUADDR

	LDA #<canvas ; ------------------------ load least significant byte from background graphic layout
	STA LOWBYTE                        
	LDA #>canvas ; ------------------------ load most significant byte from background graphic layout
	STA HIGHBYTE
	LDX #$00                         
	LDY #$00
@load_background_loop:
	LDA ($01), Y ; ------------------------ (indirect),Y => go over low bytes
	STA PPUDATA
	INY
	CPY #$00
	BNE @load_background_loop
	INC HIGHBYTE ; ------------------------ increment memory by one
	INX
	CPX #$04
	BNE @load_background_loop



vblankwait: ; ----------------------------- wait for another vblank before continuing
    BIT PPUSTATUS
    BPL vblankwait
    LDA #%10010000 ; ---------------------- turn on NMIs, sprites use first pattern table
    STA PPUCTRL
    LDA #%00011110 ; ---------------------- turn on screen
    STA PPUMASK

forever:
    JMP forever
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
    .byte $0f, $00, $00, $00
    .byte $0f, $00, $00, $00
    .byte $0f, $00, $00, $00
    .byte $0f, $00, $00, $00

.include "canvas.asm" ; ----------------- background graphic layout


.segment "CHR"
.incbin "background.chr"
