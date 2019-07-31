; FV-1 Testing
;
; Program: DAC Persistence
;
; POT0 : WRITE?
;
; Expected output:
;	- DAC holds value

	rdax	ADCL,1.0
	wrax	REG0,0.0
	sof	0.0,-0.5
	rdax	POT0,1.0
	skp	NEG,end
	ldax	REG0
	wrax	DACL,0.0
end:
