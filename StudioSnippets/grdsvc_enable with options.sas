%let rc=%sysfunc(grdsvc_enable(_all_,server=SASApp; jobname=jnvar; jobopts=jovar; ));
 
%let jnvar=Demo22;
%let jovar=queue=priority;