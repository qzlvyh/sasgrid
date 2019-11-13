/* Chapter 2 Demo */

/* Start a new grid session and submit a code block */

/* 1. enable Grid resource */
%let rc=%sysfunc(grdsvc_enable(_all_,server=SASApp));

/* 2. signon to Grid */
signon session1;

/* 3. remote submit to Grid */
rsubmit session1;

    %put "PROC MEANS is running on &syshostname at %sysfunc(time(),time11.2) as gird job id %sysget(LSB_JOBID)";

	proc means data=sashelp.cars;
	   var mpg_city;
	   class origin type;
	run;

/* 4. end remote submit */
endrsubmit; 

/* 5. signoff Grid */
signoff session1; 
