; FV-1 Testing Bank
;
; Check behaviour of FV-1 against documentation
;

; Program 3 : Skip Flags

; POT0 : TESTMODE NEG|ZRO|GEZ
;
;	- use pot to choose mode / extra flag: run, zro, gez, neg
;	- confirm mode on DACR
;	- note: assumes unconditional clr skp ZRO,target working
;
;					  neg | zro | gez
equ	mode0	-0.9		; mode 0:  *  |     |
equ	mode1	-0.6		; mode 1:  *  |  *  |
equ	mode2	-0.3		; mode 2:  *  |  *  |  *
equ	mode3	0.0		; mode 3:     |  *  |
equ	mode4	0.3		; mode 4:     |  *  |  *
equ	mode5	0.6		; mode 5:  *  |     |  *
equ	mode6	0.9		; mode 6:     |     |  *
equ	CUR	REG0
equ	PREV	REG1
equ	MAX	REG2

	skp	RUN,read
	clr
	or	0x7fffff
	wrax	MAX,0.0

read:	ldax	ADCL
	and	0xfffff0	; mask off low bits
	wrax	CUR,0.0

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

; test 6 GEZ only
test6:	clr
	or	mode6
	wrax	DACR,0.0
	ldax	CUR
	skp	GEZ,mark
	clr
	skp	ZRO,space

; test 0 GEZ only
test0:	clr
	or	mode0
	wrax	DACR,0.0
	ldax	CUR
	skp	NEG,mark
	clr
	skp	ZRO,space

; test 1 NEG|ZRO
test1:	clr
	or	mode1
	wrax	DACR,0.0
	ldax	CUR
	skp	NEG|ZRO,mark
	clr
	skp	ZRO,space

; test 2 NEG|ZRO|GEZ
test2:	clr
	or	mode2
	wrax	DACR,0.0
	ldax	CUR
	skp	NEG|ZRO|GEZ,mark
	clr
	skp	ZRO,space

; test 3 ZRO
test3:	clr
	or	mode3
	wrax	DACR,0.0
	ldax	CUR
	skp	ZRO,mark
	clr
	skp	ZRO,space

; test 4 ZRO|GEZ
test4:	clr
	or	mode4
	wrax	DACR,0.0
	ldax	CUR
	skp	ZRO|GEZ,mark
	clr
	skp	ZRO,space

; test 5 NEG|GEZ
test5:	clr
	or	mode5
	wrax	DACR,0.0
	ldax	CUR
	skp	NEG|GEZ,mark
	clr
	skp	ZRO,space

; write a space to output - assumes ACC clear
space:	wrax	DACL,0.0
	skp	ZRO,end

; write a mark to output
mark:	ldax	MAX
	wrax	DACL,0.0

; save current sample for next iteration
end:	ldax	CUR
	wrax	PREV,0.0

