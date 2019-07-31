; FV-1 Testing
;
; Program: SKP Too Far
;
; What does skip do when target is beyond end of program
;       - ?

pad:	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
test:	or	0x7fffff	; load max value
	wrax	DACL,0.0	; make sure output is cleared
	raw	0x05000011	; invalid skip:		skp 0,40
	or	0x800000	; load a minimum value
	wrax	DACR,0.0	; write out
