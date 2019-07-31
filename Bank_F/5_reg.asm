; FV-1 Testing
;
; Program: Read reg 0x1d
;
; POT0: Test Value
;
; Check read register 0x1d
;

	skp	RUN,main
	wlds	SIN0,0x03f,0x7fff	; SIN0
	wlds	SIN1,0x07f,0x7fff	; SIN1
	wldr	RMP0,0x2000,4096	; RMP0
	wldr	RMP0,0x4000,4096	; RMP1

main:	clr
	rdax	0x1d,1.0		; load reg 0x1d
	wrax	DACL,0.0		; write to DACL
	cho	sof,SIN0,REG|COMPA,0.0	; "register" SIN0
	cho	sof,SIN1,REG|COMPA,0.0	; "register" SIN1
	cho	sof,RMP0,REG|COMPA,0.0	; "register" RMP0
	cho	sof,RMP1,REG|COMPA,0.0	; "register" RMP1
	clr
	;or	0x5a5a5a		; load test pattern
	ldax	POT0			; load test pattern
	wra	0,0.0			; write to delay
	rda	0x7fff,1.0		; read from end of delay and into LR
	wrax	REG0,0.0		; save to temp reg
	or	-0.5000 		; load garbage value
	not				; flip all the bits
	ldax	0x1d			; load test reg
        rdax	REG0,-1.0		; subtract temp value from rda
	skp	ZRO,mark
	skp	0,space
mark:	or	0x7fffff		; mark equal with max val
space:	wrax	DACR,0.0		; write to DACR
