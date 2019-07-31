; FV-1 Testing
;
; Program: PACC Persist
;
; Expected output if PACC persists:
;	- first sample output should be MIN
;	- all following samples should be MAX

equ	maxval	0x7fffff
equ	minval	0x800000
equ	MAX	REG0
equ	MIN	REG1
equ	JUNK	REG2

	skp	RUN,main
	clr
	or	maxval		; load maximum flag value
	wrax	MAX,0.0
	or	minval		; load minimum flag value
	wrax	MIN,0.0		; ACC is now zero, PACC is MIN

main:
	wrhx	JUNK,0.0	; exchange PACC and ACC
	wrax	DACL,1.0	; write out ACC
	clr
	or	maxval
	ldax	MIN		; end routine with ACC set to MIN and
				; PACC set to MAX
