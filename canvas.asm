\\ MODE 7 Teletext Canvas

\\ Include bbc.h
BYTEV=&20A
WRCHV=&20E
EVNTV=&220

oswrch=&FFEE
osbyte=&FFF4
osfile=&FFDD

argv = &F2

MAX_ROWS = 200

ORG &70
GUARD &8F

\\ ZP
.current_row SKIP 1

ORG &1900
GUARD &7000

.start

.main
{
    lda #22:jsr oswrch
    lda #7:jsr oswrch

	\\ Turn off cursor by directly poking crtc
	SEI
	LDA #10: STA &FE00
	LDA #32: STA &FE01
	CLI	

    LDX #0

    .loop_down
    STX current_row

    LDA #19
    JSR osbyte

    LDX current_row
    JSR copy_from_row

    LDX current_row
    INX
    CPX #MAX_ROWS-25
    BNE loop_down
    DEX

    .loop_up
    STX current_row

    LDA #19
    JSR osbyte

    LDX current_row
    JSR copy_from_row

    LDX current_row
    BEQ done_up
    DEX
    JMP loop_up
    .done_up

    .loop_keys

    LDA#&81:LDX#LO(-66):LDY#&FF:JSR osbyte:TYA:BEQ not_up
    LDX current_row
    BEQ not_up
    DEX
    STX current_row
    .not_up

    LDA#&81:LDX#LO(-98):LDY#&FF:JSR osbyte:TYA:BEQ not_down
    LDX current_row
    CPX #MAX_ROWS-25
    BCS not_down
    INX
    STX current_row
    .not_down
    
    LDA #19
    JSR osbyte

    LDX current_row
    JSR copy_from_row

    JMP loop_keys

    .return
    RTS
}

.copy_from_row
{
    CLC
    LDA mult40_LO, X
    ADC #LO(data)
    STA read_addr+1
    LDA mult40_HI, X
    ADC #HI(data)
    STA read_addr+2

    LDA #0
    STA write_addr+1
    LDA #&7C
    STA write_addr+2

    LDY #4

    .outer
    LDX #0

    .loop

    .read_addr
    LDA data, X

    .write_addr
    STA &7C00, X

    INX
    BNE loop
    
    INC read_addr+2
    INC write_addr+2

    DEY
    BNE outer

    .return
    RTS 
}

.mult40_LO
FOR n,0,MAX_ROWS-1,1
EQUB LO(n*40)
NEXT

.mult40_HI
FOR n,0,MAX_ROWS-1,1
EQUB HI(n*40)
NEXT

.data
;INCBIN "castle_bw.txt.bin"
INCBIN "castle_colour.txt.bin"

.end

SAVE "canvas", start, end, main, start
