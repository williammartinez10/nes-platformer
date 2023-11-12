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
    ; ------------------------------------- write a palette
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

    ; ------------------------------------- write sprite data
    LDX #$00
load_sprites:
    LDA sprites,X
    STA $0200,X
    INX
    CPX #$d0
    BNE load_sprites


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


sprites:
    ; #############################
    ; ----------- still -----------
    ; #############################
    ; ----------------------------------- facing right
    .byte $c8, $11, $00, $08
    .byte $d0, $21, $00, $08
    .byte $c8, $12, $00, $10
    .byte $d0, $22, $00, $10
    ; ----------------------------------- facing left
    .byte $c8, $11, %01000000, $20
    .byte $d0, $21, %01000000, $20
    .byte $c8, $12, %01000000, $18
    .byte $d0, $22, %01000000, $18


    ; #############################
    ; ---------- walking ----------
    ; #############################
    ; ----------------------------------- facing right
    ; ---------- 1 ---------
    .byte $b0, $11, $00, $18
    .byte $b0, $12, $00, $20
    .byte $b8, $45, $00, $18
    .byte $b8, $46, $00, $20
    ; ---------- 2 ----------
    .byte $b0, $11, $00, $28
    .byte $b0, $12, $00, $30
    .byte $b8, $2c, $00, $28
    .byte $b8, $2d, $00, $30
    ; ---------- 3 ----------
    .byte $b0, $11, %00, $08
    .byte $b0, $12, %00, $10
    .byte $b8, $43, %00, $08
    .byte $b8, $44, %00, $10

    ; ----------------------------------- facing left
    ; ------------- 1 ------------
    .byte $98, $11, %01000000, $20
    .byte $98, $12, %01000000, $18
    .byte $a0, $45, %01000000, $20
    .byte $a0, $46, %01000000, $18
    ; ------------- 2 ------------
    .byte $98, $11, %01000000, $30
    .byte $98, $12, %01000000, $28
    .byte $a0, $2c, %01000000, $30
    .byte $a0, $2d, %01000000, $28
    ; ------------- 3 ------------
    .byte $98, $11, %01000000, $10
    .byte $98, $12, %01000000, $08
    .byte $a0, $43, %01000000, $10
    .byte $a0, $44, %01000000, $08


    ; ############################
    ; --------- jumping ----------
    ; ############################
    ; ----------------------------------- facing right
    .byte $80, $11, $00, $08
    .byte $80, $12, $00, $10
    .byte $88, $25, $00, $08
    .byte $88, $26, $00, $10 
    ; ----------------------------------- facing left
    .byte $80, $11, %01000000, $30
    .byte $80, $12, %01000000, $28
    .byte $88, $25, %01000000, $30
    .byte $88, $26, %01000000, $28


    ; ###########################
    ; -------- game over --------
    ; ###########################
    ; ----------------------------------- only faces forward
    .byte $78, $40, $00, $18
    .byte $78, $41, $00, $20
    .byte $70, $30, $00, $18
    .byte $70, $31, $00, $20



.segment "CHR"
.incbin "player.chr"
