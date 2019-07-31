; FV-1 Testing
;
; Program: Zero Crossing
;
; POT0: TESTMODE: ZRC|flag  
;
;	- use pot to choose mode / extra flag: run, zro, gez, neg
;	- confirm mode on DACR

equ	mode0	-0.9		; mode 0: no extra flags
equ	mode1	-0.5		; mode 1: add with run flag
equ	mode2	0.0		; mode 2: add with zro flag
equ	mode3	0.5		; mode 3: add with gez flag
equ	mode4	0.9		; mode 4: add with neg flag
equ	CUR	REG0
equ	PREV	REG1
equ	MAX	REG2

	skp	RUN,read
	clr
	or	0x7fffff
	wrax	MAX,0.0

read:	ldax	ADCL
	and	0xfffff0	; mask off low bits
	wrax	CUR,0.0		; save current sample to CUR

; use pot to determine which test to run:
	or	0x0000ff	; put small offset in ACC
	rdax	POT0,-1.0	; read pot0 inverted and add to ACC
	skp	GEZ,noflag
	sof	1.0,0.125
	skp	GEZ,runflag
	sof	1.0,0.125
	skp	GEZ,zroflag
	sof	1.0,0.125
	skp	GEZ,gezflag
	sof	1.0,0.125
	skp	GEZ,negflag

; no test
notest:	clr
	wrax	DACR,0.0
	wrax	DACL,0.0
	skp	ZRO,end

; test zero crossing with no other flags set
noflag:
	clr
	or	MODE0
	wrax	DACR,0.0
	ldax	PREV
	ldax	CUR
	skp	ZRC,mark
	clr
	skp	ZRO,space

; test zero crossing combined with run flag
runflag:
	clr
	or	MODE1
	wrax	DACR,0.0
	ldax	PREV
	ldax	CUR
	skp	ZRC|RUN,mark
	clr
	skp	ZRO,space

; test zero crossing combined with zro flag
zroflag:
	clr
	or	MODE2
	wrax	DACR,0.0
	ldax	PREV
	ldax	CUR
	skp	ZRC|ZRO,mark
	clr
	skp	ZRO,space

; test zero crossing combined with gez flag
gezflag:
	clr
	or	MODE3
	wrax	DACR,0.0
	ldax	PREV
	ldax	CUR
	skp	ZRC|GEZ,mark
	clr
	skp	ZRO,space

; test zero crossing combined with neg flag
negflag:
	clr
	or	MODE4
	wrax	DACR,0.0
	ldax	PREV
	ldax	CUR
	skp	ZRC|NEG,mark
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

