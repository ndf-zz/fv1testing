; FV-1 Testing
;
; Program: Prepare Test 4
;
	or	0x7fffff
	skp	RUN,main
	wrax	REG0,1.0
main:	wrax	DACL,0.0
	ldax	REG0
	wrax	DACR,0.0
