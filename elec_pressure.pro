FUNCTION elec_pressure_loop, abundances, phis, p_e, p_g
	;+
	; NAME:
	;	elec_pressure_loop()
	;
	; PURPOSE:
	;	To perform the summations in eq 9.8 in Gray, and return the calculated
	;	electron pressure p_e after one iteration
	;
	; CALLING SEQUENCE:
	;	res = elec_pressure_loop(abundances, phis, p_e, p_g)  
	;
	; INPUT PARAMETERS:
	;	abundances	The Solar abundances (array of numbers for elements 1 to 92)
	;	phis,		The Phi for each element from 1 to 92 at a given temp (array)
	;	p_e,		The electron pressure calculated from a previous iteration (number)
	;	p_g        	The gas pressure (number)
	; 
	; OPTIONAL INPUT:
	;
	; OUTPUT PARAMETERS:
	;	res	  The calculated value of p_e after one iteration.
	;		- If you run this program often, recursively, p_e should converge
	;		on the correct answer
	; 
	; NOTES:
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date March, 20
	;-

	numElem = n_elements(abundances)

	; -----------------------------------------------------------
	; Calculate the sums in EQ 9.8 in Gray
	numer = 0.0D
	denom = 0.0D
	; -----------------------------------------------------------
	FOR j = 0, numElem-1 DO BEGIN
		numer = numer + abundances[j] * ((phis[j]/p_e)/(1.0D + phis[j]/p_e))
		denom = denom + abundances[j] * (1.0D + (phis[j]/p_e)/(1.0D + phis[j]/p_e))
	ENDFOR
	calc_p_e = p_g*numer/denom
	; -----------------------------------------------------------

	RETURN, calc_p_e
END

FUNCTION elec_pressure, temp, logp_g
	;+
	; NAME:
	;	elec_pressure()
	;
	; PURPOSE:
	;	To calculate the electron pressure given by eq 9.8 in Gray.
	;	This is done by iteration - see also the helper function:
	;	- elec_pressure_loop()
	;
	; CALLING SEQUENCE:
	;	res = elec_pressure(p_e, p_g)  
	;
	; INPUT PARAMETERS:
	;	temp	   The temperature in Kelvins
	;	logp_g     The base10 logarithm of the gas pressure
	; 
	; OPTIONAL INPUT:
	;
	; OUTPUT PARAMETERS:
	;	res	  The base10 logarithm of the electron pressure, based on a few
	;		iterations that should converge to the right number, the stopping
	;		threshold is set to eps=1D-10
	; 
	; NOTES:
	;	Equation 9.8 in Gray is transcendental in p_e, so we will need to iterate
	;	- The function should converge fast to the right answer.
	;	The first guess value of p_e is dependent on the input temperature, and p_g
	;	 - see discussion below eq. 9.8 in Gray

	;	The program depends on the following functions:
	;	- phit()
	;	- get_abundances()
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date March 4 2014
	;	- Updates on March 20, 2014
	;-

	; -----------------------------------------------------------
	; Threshold to stop iterating
	eps = 1D-10
	p_g = 10^(logp_g)

	abund_data = get_abundances()
	elements   = abund_data.field2
	abundances = abund_data.field4

	; 'abundances' contains a few NaNs - we substitude those for 0
	abundances_nonan = nan_to_num(abundances, 0.0D)

	numElem = n_elements(elements)
	phis = make_array(numElem,1,/DOUBLE, value=0) 
	calc_p_e = make_array(2,1,/DOUBLE, value=0) 
	; -----------------------------------------------------------

	; Elements that do not have a '+' ion listed in 'ioniz.txt'
	badElements = ['Li', 'Cs']

	; -----------------------------------------------------------
	; Calculate all the phis, which are then passed to 'elec_pressure_loop'
	; - this saves a lot of computing time
	i=0
	WHILE i LT numElem DO BEGIN
		; Lets set the bad elements to 0
		IF WHERE(elements[i] EQ badElements) NE -1 THEN BEGIN
			phis[i] = 0
		ENDIF ELSE BEGIN
			; These elements work correctly
			phis[i] = phit(elements[i],temp)
		ENDELSE
		i = i + 1
	ENDWHILE
	; -----------------------------------------------------------

	; -----------------------------------------------------------
	; Initial guesses
	; Calculate first value
	IF temp GT 30000. THEN BEGIN
		; See criterion in Gray - a bit below eq 9.8
		calc_p_e[0] = p_g/2.0D
	ENDIF ELSE BEGIN
		; Use phit for H
		calc_p_e[0] = sqrt(p_g*phit('H',temp))
	ENDELSE
	; Calculate the second element 
	calc_p_e[1] = elec_pressure_loop(abundances, phis, calc_p_e[0], p_g)
	; -----------------------------------------------------------

	; -----------------------------------------------------------
	; Iterate
	WHILE abs(calc_p_e[1] - calc_p_e[0]) GT eps DO BEGIN
		calc_p_e[0] = calc_p_e[1]
		calc_p_e[1] = elec_pressure_loop(abundances, phis, calc_p_e[1], p_g)
		diff = abs(calc_p_e[1] - calc_p_e[0])
		print, "Difference", diff
	ENDWHILE
	print, "Iterations converged, threshold, ", eps
	; -----------------------------------------------------------

	RETURN, alog10(calc_p_e[1])
END

