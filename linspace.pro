FUNCTION LINSPACE, A, B, N
	;+
	; NAME:
	;	LINSPACE()
	; PURPOSE:
	;	To create an array of N equally spaced values between the endpoints A and B
	;
	; CALLING SEQUENCE:
	;	myArray = LINSPACE( A, B, N)
	;
	; INPUT PARAMETERS:
	;	A         Left endpoint
	;	B         Right endpoint
	;	N         Number of points in myArray
	;
	; OUTPUT PARAMETERS:
	;       myArray   Array of equally spaced numbers, ranging from A to B; N in total
	;
	; NOTES:
	; 	Code based on code shown in the following website:
	; 	  https://klassenresearch.orbs.com/Emulate+linspack+and+logspace
	;	but it did not include any documentation
	;
	; MODIFICATION HISTORY
	;	G. K. Stefansson - January 23, 2014
	;-
	L = DINDGEN(N) / (N - 1.0D) * (B - A) + A
	return, L
END
