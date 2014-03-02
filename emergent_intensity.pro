FUNCTION emergent_intensity, tau, sourcef, mu
	;+
	; NAME:
	;	EMERGENT_INTENSITY()
	;
	; PURPOSE:
	;	To numerically intigrate a given source-function, SOURCEF
	;	over the tau values TAU at an angle MU
	;
	; CALLING SEQUENCE:
	;	intens = EMERGENT_INTENSITY(tau, sourcef, mu)  
	;
	; INPUT PARAMETERS:
	;	TAU	- The values of tau, the integration variable,
	;		  usually, TAU = LINSPACE(min, max, N) 
	;	SOURCEF - The corresponding sourcefunction values at each of the
	;		  TAU values, i.e.  SOURCEF = S(TAU)
	;	MU	- MU, MU=cos(\theta), where \theta is the angle between
	;		  the incident ray, and the radial direction; example:
	;		  MU = 1 for the radial direction, but MU=0 for tangential
	;
	; OUTPUT PARAMETERS:
	;	INTENS =  the calculated emergent intensity 
	; 
	; NOTES:
	;	See Rutten's note page 18
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - Jan 28
	;
	;-
	expfunc = exp(-tau/mu)	
	integrand = expfunc*sourcef/mu
	intens = int_tabulated(tau,integrand)
	RETURN, intens
END
