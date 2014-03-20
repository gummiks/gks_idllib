FUNCTION nan_to_num, myArray, num
	;+
	; NAME:
	;	nan_to_num()
	;
	; PURPOSE:
	;	To change all NaNs to a number, 'num'
	;
	; CALLING SEQUENCE:
	;	res = nan_to_num(myarray)  
	;
	; INPUT PARAMETERS:
	;	myarray   An array to be parsed
	;	num	  The number to set the NaNs to
	; 
	; OPTIONAL INPUT:
	;
	; OUTPUT PARAMETERS:
	;	res	  The same array as myArray, except, all NaNs have been 
	;		  substituded for 'num'
	; NOTES:
	;	
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date March 19, 2014
	;	
	;-

	myArray[where(~finite(myArray))] = num
	RETURN, myArray
END

