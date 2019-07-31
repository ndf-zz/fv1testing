; FV-1 Testing
;
; Program: Delay Init Val
;
; Expected output: 0.0

	clr
	rda	0,1.0		; read from delay
	wrax	DACL,0.0
