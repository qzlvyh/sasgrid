/* SAS Macros to support reusing sessions in parallel processing */
/* 
	
*/

/* macro to initialize macro variables */
%macro initVars(numSessions);
	%do sess=1 %to &numSessions;
		%global mySignonVar&sess;
		%global myRsubmitVar&sess;
		%let mySignonVar&sess=3;
		%let myRsubmitVar&sess=0;
	%end;
%mend;

