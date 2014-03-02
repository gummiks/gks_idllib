FUNCTION kappa_Hm_bf_alpha_bf, lambda, DOPLOT=plotting
	;+
	; NAME:
	;	kappa_Hm_bf_alpha_bf()
	;
	; PURPOSE:
	;	To calculate the absorption coefficient alpha_bf(H-) in units 10^(-18) cm^2 /H- ion
	;	for lambda in the range: (2250A, 15000A)
	;
	; CALLING SEQUENCE:
	;	res = kappa_Hm_bf_alpha_bf(lambda)  
	;
	; INPUT PARAMETERS:
	;	lambda        The wavelength in Angstroms (array)
	; 
	; OPTIONAL INPUT:
	;	DOPLOT	      Plot the values where alpha is a good approximation: for lambda = (2250A, 15000A)
	;
	; OUTPUT PARAMETERS:
	;	res	      The calculated absorption coefficient (if lambda array - then array)
	; 
	; NOTES:
	;	The allowed values for lambda are between 2250A and 15000A
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date 26th of February 2014
	;-

	; See the polynomial constants in Gray page 156
	pol_const = [1.99654,    $
		    -1.18267D-5, $
		     2.64243D-6, $
		    -4.40524D-10,$
		     3.23992D-14,$
		    -1.39568D-18,$
		     2.78701D-23]
	alpha_hm_bf = poly(lambda, pol_const)*(1.0D-18)

	IF KEYWORD_SET(plotting) THEN BEGIN
		l = linspace(2250, 15000, 1000)
		calc_alpha = poly(l,pol_const)*(1.0D-18)
		cgWindow
		!x.thick=4
		!y.thick=4
		; nstring = strtrim(n, 2)
		xstr = TexToIDL('\lambda') 
		ystr = TexToIDL('\alpha') 
		cgPlot, l, calc_alpha, color='red', xstyle=1, ystyle=2, font=-1, /window, thick=3, $
			Aspect=2./3, XTitle=xstr, YTitle=ystr, charsize=2 , /ylog
	ENDIF
	RETURN, alpha_hm_bf
END

FUNCTION kappa_Hm_bf, lambda, theta, p_e, STIMULATED=stim, UNIT_PRESSURE=unit
	;+
	; NAME:
	;	kappa_Hm_bf()
	;
	; PURPOSE:
	;	To calculate the Bound-Free opacity of the H- ion in cm^2 per neutral hydrogen atom
	;	for a given lambda (in Angstroms), theta=5040K/T and electron pressure p_e
	;	see eq. 8.12 in Gray
	;
	; CALLING SEQUENCE:
	;	res = kappa_Hm_bf(lambda, theta, p_e)  
	;
	; INPUT PARAMETERS:
	;	lambda          The wavelength in Angstroms (array)
	;       theta   	Theta values: theta = 5040K/T where T is the temperature in Kelvins
	;	p_e		The electron pressure
	; 
	; OPTIONAL INPUT:
	;	STIMULATED                  Include the stimulated emission factor
	;	UNIT_PRESSURE               Give the answer 'in per unit pressure'
	;
	; OUTPUT PARAMETERS:
	;	res	  The calculated opacity for the H- ion (kappa(H-_bf) - see eq 8.12, page 156 in Gray
	; 
	; NOTES:
	;	kappa_Hm_bf() depends on the helper function kappa_Hm_bf_alpha_bf() which gives the alpha_bf values
	;	for the H- ions, and the alpha_bf values are only valid for 2250A < lambda < 15000A, so 
	;       for values outside this range we set kappa_Hm_bf = 0
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date Feb 26 2014
	;-

	kappahmbf = (4.158D-10)*kappa_Hm_bf_alpha_bf(lambda)*p_e*(theta^(2.5D))*10.0D^(0.754*theta)

	;kappahmbf2 = kappahmbf*(1.0D - 10.0^(-chi_lambda*theta))
	; Per unit p_e & including the stimulation emission factor

	IF KEYWORD_SET(stim) THEN BEGIN
		; Include stimulated emission factor
		chi_lambda = 1.2398D4/lambda
		kappahmbf = kappahmbf*(1.0D - 10.0^(-chi_lambda*theta))
	ENDIF

	IF KEYWORD_SET(unit) THEN BEGIN
		; Give the answer in 'per unit pressure'
		kappahmbf = kappahmbf/p_e
	ENDIF

	; These calculations only work for 2250A < lambda < 15000 - so lets set the other values to 0
	kappahmbf[WHERE(lambda GT 15000,/NULL)] = 0
	kappahmbf[WHERE(lambda LT 2250,/NULL)] = 0
	RETURN, kappahmbf
END

