; FV-1 Testing
;
; Program: SKP No Flags
;
; What does skip do when no condition is set?
;       - left output follows left input if no skip performed

	ldax	ADCL
	skp	0,end
	wrax	DACL,0.0
end:
