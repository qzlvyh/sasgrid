/* SAS Macros to support reusing sessions in parallel processing */
/* 
	
*/

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

