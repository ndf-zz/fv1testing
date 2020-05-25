# FV1 Test Programs

A collection of test programs and examples for the
Spin Semiconductor FV-1 reverb IC. Connect a scope
directly to FV-1 DA outputs to monitor test results.

## Test Programs and Results

### Overview

- On program change, all registers, accumulators and delay memory
  locations are initialised with 0.0. DACs are held at 0.0 for about
  18ms, then the program starts, DACs are ramped up during the first
  few samples.

- Skip flags combine by AND:
  "Perform skip if all flagged conditions are met."
  When flags are clear, all flagged conditions are met regardless of the 
  content of ACC, and an unconditional skip is performed.

- ADDR_PTR, DACR & DACL do not allow read access.

- Instruction cho rdal uses condition flags to register LFO and to 
  select read from COS. Other cho flags have no impact on rdal output.

### Bank A: Load & Initialise

- 0: Output 0.0 to DACL.

     Result: DAC outputs ~1.7V

- 1: Output maximum value to DACL

     Result: DAC outputs ~3.1V

- 2: Output minimum value to DACL

     Result: DAC Outputs ~0.3V

- 3: Check copy to and from REG

     Output: DACL is max for PASS, min for FAIL

     Result: PASS, wrax/ldax yield same result

- 4: Check REG initial value

     Output: REG initial value is written to DACL

     Result: REG is initialised with 0.0

- 5: Check PACC initial value

     Output: PACC initial value is written to DACL

     Result: PACC is initialised with 0.0

- 6: Check ACC initial value

     Output: ACC initial value is written to DACL

     Result: ACC is initialied with 0.0

- 7: Check delay initial value

     Output: Delay content is written to DACL

     Result: Whole delay line is initialised with 0.0


### Bank B: Register Persistence & ADDA

- 0: Check ACC persistence.

     Output: DACL is max for PASS, min for FAIL

     Result: ACC persists OK

- 1: Check ACC as delay element

     Output: DACL varies from min to max for PASS

     Result: Output steadily increases OK

- 2: Check PACC persistence

     Output: DACL is max for PASS, min for FAIL

     Result: PACC persists OK

- 3: Check REG persistence

     Output: DACL varies from min to max for PASS

     Result: REG persists OK

- 4: Check DAC holds last written value on program change

     Result: DAC is muted for about 18ms then output returns to
     last written value

- 5: Check DAC persistence within program

     ADCL is transferred to DACL if POT0 is > ~0.5, otherwise DACL is
     not written.

     Result: DAC holds last written value

- 6: ADC multiple reads return same value

     Output: DACL is max if ADCL is exactly same, min if different.

     Result: ADC returns same value throughout program

- 7: DAC multiple writes output only last written

     Output: DACL is written with min, then overwritten with max

     Result: DAC outputs last written value in program


### Bank C: SKP Flags and raw LFOs

- 0: Unconditional SKP

     Output: ADCL is written to DACL if no skip is performed, else output 0.0

     Result: skp with flags=0 performs unconditional skip

- 1: All SKP flags set

     Output: ADCL is written to DACL if no skip is performed, else output 0.0

     Result: skp with flags=0x1f never skips

- 2: Zero crossing flag combinations

     Output: Test mode is written to DACR, zero crossings are written to DACL

     Result: RUN,GEZ,NEG combine with ZRC. ZRO does not combine

- 3: Skip on Zero & Sign

     Results: Skip flags combine by AND:

     * NEG : skips
     * NEG|ZRO : does not skip
     * NEG|ZRO|GEZ : does not skip
     * ZRO : skips
     * ZRO|GEZ : skips but only on ZERO
     * NEG|GEZ : does not skip
     * GEZ : skips

- 4: Check LFO raw outputs

     Result: SIN LFO varies over full range -1.0 to 1.0. RMP LFO
     varies over range 0.0 to 0.5

- 5: Check SIN interpolation values

     Result: SIN interpolation varies smoothly over range 0.0 to 1.0

- 6: Check RMP crossfade value

     Result: Crossfade coefficient varies smoothly over range 0.0 to 1.0

- 7: Check RMP interpolation values

     Result: RMP interpolation varies smoothly over range 0.0 to 1.0 as with
     SIN interploation

### Bank D: Misc Undocumented

- 0: SKP past end of program

     Result: Skp to end of program

- 1: Negative ADDR_PTR

     Result: Sign bit is ignored, address bits 0x7fff00 used directly

- 2: Check CHO rdal,SIN flags

     Result: For SIN LFO, REG flag must be set, otherwise no output is
     provided, and flags COMPC, COMPA are ignored.

- 3: Check CHO rdal,RMP flags

     Result: REG must be set as with SIN lfo and all flags are ignored.

- 4: Invalid WLDR

     Result: Invalid frequency is accepted and works as expected.

- 5: Read from DACL

     Result: DACL reads as 0.0

- 6: Read back ADDR_PTR

     Result: ADDR_PTR reads as 0.0

- 7: Write to ADCL

     Result: Write to ADCL does not change read value

### Bank E: Check read from undocumented registers

- 0: Register 0x08
- 1: Register 0x09
- 2: Register 0x0a
- 3: Register 0x0b
- 4: Register 0x0c
- 5: Register 0x0d
- 6: Register 0x0e
- 7: Register 0x0f

Reads from registers 0x08 - 0x0f return the same value as ACC.

### Bank F: Check read from undocumented registers

- 0: Register 0x13
- 1: Register 0x19
- 2: Register 0x1a
- 3: Register 0x1b
- 4: Register 0x1c
- 5: Register 0x1d
- 6: Register 0x1e
- 7: Register 0x1f

Reads from registers 0x13, 0x19 - 0x0f return the same value as ACC.

### Bank G: Delay Line Checks

- 0: Measure delay error

     Result: Floating point appears to have one bit of sign, three bits of
     exponent and 10 bits of value. Max error is roughly 13 bits at full
     scale, about 0.1% across signal range.

- 1: Check double delay error fix

     Result: Error is reduced below 3 bits - compare DACR on
     program 0 to program 1. Note: Negative error values indicate
     exact comparison after fetch.

- 2: Delay address servo from POT

     Ramp servos with slight lag.

- 3: Delay address servo from ADC

     Ramp servos with slight lag.

- 4: LFO cho sof,... output

     Result: Without flags, cho,sof outputs the k interpolation value

- 5: Interpolated delay read

     Signal is frequency modulated as expected
   
- 6: Crossfade with ramp LFO

     Signal is faded in and out as expected

- 7: Frequency shift example

     Test of example from AN-0001

### Bank H: Misc Computation Checks

- 0: Raw LFO output

     Result: cho RDAL uses cho flags to choose COS output from SIN LFO

- 1: Windowed Sinc FIR Lowpass
- 2: Random FIR

     Despite limited accuracy of filter tap multipliers,
     FIRs work quite well.

- 3: Hold DACL and DACR at +1.0 for next test init

- 4: Program start delay

     DACL and DACR are held at 0.0 for ~18ms on program change.
     The program is started, then one sample later the DACs start
     updating with program content (Confirmed due to DAC being ramped up)

- 5: SOF clipping order

     Guard bits in multiplier retain overflow until after offset is applied

- 6: RDAX clipping order

     Guard bits in multiplier retain overflow until after accumulate

- 7: RDFX clipping order

     Guard bits in multiplier retain overflow until after final accumulate

### Bank I: Log / Exp

- 0: raw log

     Output: Take log of an LFO and output to DACR.

- 1: raw exp

     Output: Take exp of an LFO and output to DACR.

- 2: exp log cancellation
 
     Test cancellation of terms: 2**(log(x)) = x within the limits of the
     FV-1.

     Result: With sign correction, exp/log cancells as expected.

- 3: log gain

     Add a DC offset to log(x) for gain: y = 2**(log(x) + gain)

     Result: POT0 gives gain factor of roughly 0.00001 to 65535.0.

- 4: log powers

     Multiply log(x) by a DC offset for powers x**(y)

- 5: 1/x

     Compute the special case 1/x using y=2**(-log(x))

     Result: all output values are saturated since abs(y) >= 1.0 for all x

- 6: square root

     Compute the special case sqrt(x) using y=2**(0.5*log(x))

- 7: division

     Compute x/y using 2**(log(x) - log(y))

### Bank J: Filters

- DFI

- DFII
 
- Cascaded

- biquad error

## License

To the extent possible under law, the author(s) have dedicated
all copyright and related and neighbouring rights to this software
to the public domain worldwide. This software is distributed
without any warranty.


## Links

- FV-1 assembler: <https://github.com/ndf-zz/asfv1>
- Dervish: <http://gbiswell.myzen.co.uk/dervish/Readme_First.html>
- Spin Semiconductor: <http://spinsemi.com/>
