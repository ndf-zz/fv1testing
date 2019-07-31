; FV-1 Testing
;
; Program: Check WRAX/LDAX
;
; Expected output: max (pass) or min (fail)
;
; Note: also leaves chkhi or chklo in REG0 for next prog

; Immediates
equ	chkhi	0xaaaaaa	; test pattern one
equ	chklo	0x555555	; test pattern two
equ	maxval	0x7fffff	; maximum immediate value
equ	minval	0x800000	; minimum immediate value

; Registers
equ	CHK	REG0		; register to hold check val

test1:	clr
	or	chkhi
	wrax	CHK,1.0		; write immediate to register
	or	0xffffff	; set all bits
	ldax	CHK		; move check value into ACC
	xor	chkhi		; compare with required value
	skp	ZRO,test2	; if same, continue
	clr
	skp	ZRO,fail	; else skip to fail

test2:	clr
	or	chklo
	wrax	CHK,1.0
	or	0xffffff
	ldax	CHK
	xor	chklo
	skp	ZRO,pass	; both tests ok

fail:	clr
	or	minval		; write fail flag
	wrax	DACL,0.0	; output to DAC
	skp	ZRO,end
pass:	clr
	or	maxval		; write pass flag
	wrax	DACL,0.0	; output to DAC
end:
