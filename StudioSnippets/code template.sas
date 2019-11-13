/* template to show correct order of statements for parallel processing */


*--- add the following statement before the steps that will be run in parallel sessionss --;

%let rc=%sysfunc(grdsvc_enable(_all_,server=SASApp));


*--- add one SIGNON statement for each grid session you want to start ---;
*--- be sure to give them all unique identifiers ---;

signon session1;


*--- put an RSUBMIT statement before the code that gets sent to the parallel session ---;
*--- change the identifier to match the signon statement ---;

rsubmit session1;


*--- put an ENDRSUBMIT statement at the end of the block of code that is being sent to the parallel session ---;

endrsubmit;


*--- put a SIGNOFF statement when you are ready to shut down all the parallel grid sessions ---;

signoff _all_;

