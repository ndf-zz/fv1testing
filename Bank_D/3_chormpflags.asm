; FV-1 Testing
;
; Program: cho rdal,RMP0,...
;
;  POT0: TESTMODE
;  POT1: LFO Rate
;  POT2: LFO Amp
;
; How do CHO flags combine for RMP LFO
;
; RMP LFO Flags:
;	REG | COMPC | COMPA | RPTR2 | NA
;					  REG | COMPC | COMPA | RPTR2 | NA
;				; DACL:       |       |       |       |
equ	mode0	-0.9		; mode 0:  *  |       |       |   *   |
equ	mode1	-0.6		; mode 1:  *  |       |   *   |       |
equ	mode2	-0.3		; mode 2:  *  |       |   *   |   *   |
equ	mode3	0.0		; mode 3:  *  |   *   |       |       |  *
equ	mode4	0.3		; mode 4:  *  |   *   |       |   *   |  *
equ	mode5	0.6		; mode 5:  *  |   *   |   *   |       |  *
equ	mode6	0.9		; mode 6:  *  |   *   |   *   |   *   |  *

main:	ldax	POT1		; read pot1 for LFO rate
	wrax	RMP0_RATE,0.0	; and clear
	ldax	POT2		; read pot2 for LFO amp
	wrax	RMP0_RANGE,0.0	; and clear

; use pot to determine which test to run:
	or	0x0000ff	; put small offset in ACC
	rdax	POT0,-1.0	; read pot0 inverted and add to ACC
	skp	GEZ,test0
	sof	1.0,0.125
	skp	GEZ,test1
	sof	1.0,0.125
	skp	GEZ,test2
	sof	1.0,0.125
	skp	GEZ,test3
	sof	1.0,0.125
	skp	GEZ,test4
	sof	1.0,0.125
	skp	GEZ,test5

; test 6 REG|COMPC|COMPA|RPTR2|NA
test6:	clr
	cho	rdal,RMP0,REG|COMPC|COMPA|RPTR2|NA
	wrax	DACR,0.0
	skp	0,end

; test 0 REG|RTPR2
test0:	clr
	cho	rdal,RMP0,REG|RPTR2
	wrax	DACR,0.0
	skp	0,end

; test 1 REG|COMPA
test1:	clr
	cho	rdal,RMP0,REG|COMPA
	wrax	DACR,0.0
	skp	0,end

; test 2 REG|COMPA|RPTR2
test2:	clr
	cho	rdal,RMP0,REG|COMPA|RPTR2
	wrax	DACR,0.0
	skp	0,end

; test 3 REG|COMPC|NA
test3:	clr
	cho	rdal,RMP0,REG|COMPC|NA
	wrax	DACR,0.0
	skp	0,end

; test 4 REG|COMPC|RPTR2|NA
test4:	clr
	cho	rdal,RMP0,REG|COMPC|RPTR2|NA
	wrax	DACR,0.0
	skp	0,end

; test 5 REG|COMPC|COMPA|NA
test5:	clr
	cho	rdal,RMP0,REG|COMPC|COMPA|NA
	wrax	DACR,0.0
	;skp	0,end

end:	cho	rdal,RMP0,REG	; compare tests to read with no flags
	wrax	DACL,0.0
