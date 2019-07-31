; FV-1 Testing
;
; Program: Startup
;
;
; Check how many samples before DAC is un-muted
;
; Check a 40ms region with two DACL spikes for 0 and 1 (use with 4)
;
EQU	fs	32768.0			; sample rate
;EQU	incr	2.0/(fs*0.00007)	; offset amount
EQU	incr	2/3; offset amount

EQU	cur	REG0			; use REG0 for counter
EQU	mark	REG1			; use REG1 for marker value
EQU	oft	REG2			; use REG2 for increment
EQU	test	REG3

	skp	RUN,main
	or	0x800000		; load neg sat val
	wrax	cur,0.0			; save
	or	incr			; save per sample update
	wrax	oft,0.0			; save

main:	ldax	cur
	wrax	DACR,1.0		; output counter to right channel
	rdax	oft,1.0			; add increment
	wrax	test,1.0		; save new value
	ldax	cur			; re-load last value
	skp	ZRC,mark0		; flag the zero point (1 sample early)
	xor	0x7fffff		; compare with positive saturation
	skp	ZRO,mark1		; flag the '+1' point
	clr
	or	0x800000
	skp	0,lout
mark1:
mark0:	clr
	or	0x7fffff
lout:	wrax	DACL,0.0

	ldax	test
	wrax	cur,0.0			; save for next update
