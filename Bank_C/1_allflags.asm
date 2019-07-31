; FV-1 Testing
;
; Program: SKP All Flags
;
; What does skip do when all conditions are set?
;       - left output follows left input if no skip performed

	ldax	ADCL
	skp	0b11111,end
	wrax	DACL,0.0
end:
