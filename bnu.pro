FUNCTION bnu, wavenum, temp
	;+
	; NAME:
	;	BNU()
	;
	; PURPOSE:
	;	To calculate the Planck function in units of erg/sec/cm2/Hz/ster
	;
	; CALLING SEQUENCE:
	;	spectrum = BNU( wavenum, temp)
	;
	; INPUT PARAMETERS:
	;	WAVENUM   Scalar or vector giving the wavenumber(s) in **microns^{-1}**
	;		   at which the Planck function is to be evaluated.
	;	TEMP 	  Scalar giving the temperature of the Planck function in **Kelvins**
	;
	; OUTPUT PARAMETERS:
	;	spectrum  - Scalar or vector givint the intensity in erg/cm2/s/Hz, at the
	;		    specified wavenumber points.
	; 
	; NOTES:
	;	See http://idlastro.gsfc.nasa.gov/ftp/pro/astro/planck.pro for a similar
	;	function, but which inputs wavelengths (in Angstroms), and temperature (in K),
	;       and outputs the BBflux (in erg/cm2/s/A) which is !pi*Intensity
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - January 22, 2014
	;	- Had the program planck.pro as a guide (see notes above)
	;-

	; DEFINE CONSTANTS
	c1 = 3.9756d-16 ; 2*h*c in cgs units
	c2 = 1.4387687d ; h*c/k in cgs units
	;---------------------------

	w = wavenum * 1.0d4 ; microns^-1 to cm^-1
	
	numer = c1*w^3
	denom = exp(c2*w/temp)-1

	val = (numer/denom)

	RETURN, val
END
