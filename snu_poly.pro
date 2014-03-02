FUNCTION snu_poly, x, a
	;+
	; NAME:
	;	snu_poly()
	;
	; PURPOSE:
	;	Calculates the value of S_nu(x) at each value of x, where x is an array of x-values;
	;	 assuming a polynomial source function: S_nu = a[0] + a[1]*x + a[2]*x^2 + ...
	;
	; CALLING SEQUENCE:
	;	sourcef = snu_poly(x, a)  
	;
	; INPUT PARAMETERS:
	;	x	  An array of x-values where the sourcefunction S_nu will be evaluated
	;	a	  An array containing the polynomial constants: S_nu = a[0] + a[1]*x + a[2]*x^2 + ...
	;
	; OUTPUT PARAMETERS:
	;	sourcef   The calculated sourcefunction values, at each x-value.
	; 
	; NOTES:
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - Feb 4, 2014
	;
	;-
	sourcef = poly(x, a)
	RETURN, sourcef
END
