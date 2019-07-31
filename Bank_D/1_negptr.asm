; FV-1 Testing
;
; Program: Negative ADDR_PTR
;
;  POT0: PTR     NEG | POS
;
; Where does negative ADDR_PTR point?

	or	0x7fffff
	wra	0,0.0		; write max to start of delay
	or	0x800000
	wra	0x3fff,0.0	; write min to halfpoint of delay

	sof	1.0,0.5		; offset start
	rdax	POT0,-1.0	; subtract POT0
	sof	-2.0,0.0	; invert and scale to full width
	wrax	DACR,1.0	; output pointer to DACR for debug
	wrax	ADDR_PTR,0.0	; write to address pointer
	rmpa	1.0		; read from delay
	wrax	DACL,0.0	; write to DACL
