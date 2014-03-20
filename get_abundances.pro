FUNCTION get_abundances
	;+
	; NAME:
	;	get_abundances()
	;
	; PURPOSE:
	;	A program that reads the file 'solar_abundances.txt' and returns an IDL datastructure which includes the abundances of elements in the sun
	;
	; CALLING SEQUENCE:
	;	res = get_abundances()  
	;
	; INPUT PARAMETERS:
	;	        
	; 
	; OPTIONAL INPUT:
	;		  
	;
	; OUTPUT PARAMETERS:
	;	res	  A solar abundance datastructure; ordered in the following way:
	;	res.field1 - Atomic number
	;	res.field2 - Name of atom
	;	res.field3 - Atomic Weight
	;	res.field4 - Solar Abundance, A
	;	res.field5 - logA
	;	res.field6 - logA12
	; 
	; NOTES:
	;	Depends on the file 'solar_abundances.txt', which is a 
	;	six column ASCII file with the following header:
	;  """
	;      #atomic	element	weight	A	logA	logA12
	;  """
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date March 19, 2014
	;-
	
	abund_data = read_struct('solar_abundances.txt',/USETEMPLATE)

	RETURN, abund_data
END

