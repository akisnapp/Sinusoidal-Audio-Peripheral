; BeepTest.asm
; Sends the value from the switches to the
; tone generator peripheral once per second.

ORG 0

	; Get the switch values
	; IN     Switches
	; Send to the peripheral
	;							OUT    Beep
	; Delay for 1 second
	; Do it again
	
; Loop:	LOAD E
	; OUT Beep
	; CALL Delay
	; LOAD A
	; OUT Beep
	; JUMP Loop
	
; TESTING LOOP

Start:
	IN Switches
	JZERO Start


Loop:
	LOAD  E
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	


	LOAD Fs ; Make an Fsharp here
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay

	LOAD  D
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay

	LOAD  B
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  A
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  E
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD  E
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD  A
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD  E
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	

	
	LOAD Fs ;Make an Fsharp and put it here
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD G
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	;First Line complete
	;Start of second line
	
	LOAD  E
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  Fs ;Make an Fsharp to put here
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	Call Delay
	CALL Delay
	
	LOAD  D
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  B
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  A
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  A
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  B
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  C
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  B
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  A
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOAD  G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	; End of second line
	
	JUMP Loop
	
Chorus:
	

	
; Subroutine to delay for 0.2 seconds.
Delay:
	OUT    Timer
WaitingLoop:
	IN     Timer
	ADDI   -1
	JNEG   WaitingLoop
	RETURN
	
playQuarter:
	STORE	arg1
	OUT 	Beep
	OUT		Timer
	
quarterLoop:
	IN		Timer
	ADDI	-10
	JNEG	quarterLoop
	LOADI	0
	OUT		Beep
	CALL	Delay
	LOAD	arg1
	RETURN
	
End:
	JUMP END
	
	
	

; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
Beep:      EQU &H40

; NOTES
A:		DW &B0011010	;A4
B:		DW &B0011100	;B4
C:		DW &B0010001	;C4
D:		DW &B0010011	;D4
E:		DW &B0010101	;E4
F:		DW &B0010110	;F4
G:		DW &B0011000	;G4
H:		DW &B0000101	;
I:		DW &B0000110
Fs:		DW &B0010111
arg1:	DW 0
arg2:	DW 0

LoopCount:	DW 0