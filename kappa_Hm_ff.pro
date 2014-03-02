FUNCTION kappa_Hm_ff, lambda, theta, p_e, UNIT_PRESSURE=unit
	;+
	; NAME:
	;	kappa_Hm_ff()
	;
	; PURPOSE:
	;	To calculate the Free-Free opacity of the H- ion in cm^2 per neutral hydrogen atom ;	for a given lambda (in Angstroms), theta=5040K/T and electron pressure p_e
	;	see eq. 8.13 in Gray
	;
	; CALLING SEQUENCE:
	;	res = kappa_Hm_ff(lambda, theta, p_e)  
	;
	; INPUT PARAMETERS:
	;	lambda          The wavelength in Angstroms (array)
	;       theta   	Theta values: theta = 5040K/T where T is the temperature in Kelvins
	;	p_e		The electron pressure
	; 
	; OPTIONAL INPUT:
	;	UNIT_PRESSURE               Give the answer 'in per unit pressure'
	;
	; OUTPUT PARAMETERS:
	;	res	  The calculated Free-Free opacity for the H- ion (kappa(H-_bf) - see eq 8.13, page 156 in Gray
	; 
	; NOTES:
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date March 1, 2014
	;
	;-
	
	; See below eq. 8.13 for f_0, f_1, and f_2 (intermediate functions to get kappa)
	f_0 = -2.2763 - 1.6850*alog10(lambda) + 0.76661*(alog10(lambda))^2.0D - 0.053346*(alog10(lambda))^3.0D
	f_1 = 15.2827 - 9.2846*alog10(lambda) + 1.99381*(alog10(lambda))^2.0D - 0.142631*(alog10(lambda))^3.0D
	f_2 = -197.789+190.266*alog10(lambda) - 67.9775*(alog10(lambda))^2.0D +  10.6913*(alog10(lambda))^3.0D - 0.625151*(alog10(lambda))^4.0D

	kk = (1.0D-26)*p_e*(10^(f_0+f_1*alog10(theta)+f_2*(alog10(theta)^2.0D)))

	IF KEYWORD_SET(unit) THEN BEGIN
		; Give the answer in 'per unit pressure'
		kk = kk/p_e
	ENDIF

	RETURN, kk
END

