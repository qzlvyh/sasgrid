/* SAS Macros to support reusing sessions in parallel processing */
/* 
	Run this code once to compile the macros for use in the exercises
	
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

/* macro to find an available session */
%macro waitForAvailableSession(numSessions);
	%global openSessID;
	%let sessFound=0;
	%do %while (&sessFound eq 0);
	   %do sess=1 %to &numSessions;
	      %if (&&mySignonVar&sess eq 0) %then	
	         %if (&&myRsubmitVar&sess eq 0) %then
	            %do;
	               %let openSessID=&sess;
	               %let sessFound=1;
	               %let sess=&numSessions;
	            %end;
	   %end;
	   %if (&sessFound eq 0) %then %let rc=%sysfunc(sleep(15));
   %end;
%mend;

