/* Chapter 2 - Exercise 5  parallel processing */

/* 
 
   SOLUTION using the minimum nuber of additional grid sessions
   
   
*/ 

libname stage '/opt/sas/data/stage';

/* delete all data tables from the stage library */
    proc datasets lib=stage nolist kill;
    quit;	

%let rc=%sysfunc(grdsvc_enable(_all_, server=SASApp; jobname=jnvar));

%let jnvar=Sess1;	
signon sess1; 

/* Section 1 - preparing the data */

rsubmit sess1 wait=no; 
	libname stage '/opt/sas/data/stage';

	data stage.group2;
	   set sashelp.heart;
	   where status = 'Alive';
	run;

endrsubmit;

	data stage.group1;
	   set sashelp.heart;
	   where status = 'Dead';
	run;

WAITFOR sess1;

/* Section 2 - analyzing the data */ 

rsubmit sess1  wait=no; 
    libname stage '/opt/sas/data/stage';
	%put "Group1 stats Starting on &syshostname at %sysfunc(time(),time11.2) as gird job id %sysget(LSB_JOBID)";
	proc means data=stage.group1 noprint n mean max min range std p90 fw=8;
		var Cholesterol weight height;
		ID Status;
		class Sex Chol_Status;
		output out=stage.group1_means;
	run;
	%put "Group1 stats Finished at %sysfunc(time(),time11.2)";
endrsubmit;

	%put "Group2 stats Starting on &syshostname at %sysfunc(time(),time11.2) as gird job id %sysget(LSB_JOBID)";
	proc means data=stage.group2 noprint n mean max min range std p90 fw=8;
		var Cholesterol weight height;
		ID Status;
		class Sex Chol_Status;
		output out=stage.group2_means;
	run;
	%put "Group2 stats Finished at %sysfunc(time(),time11.2)";

WAITFOR sess1;

/* Section 3 - the final reports */


	data combo;
		set stage.group1_means
		    stage.group2_means;
		where _type_=3 and _stat_ = 'MAX';
	run;	
	
	proc sgplot data=combo;
		vbar Chol_Status / response=Weight group=Status groupdisplay=cluster;
		yaxis grid;
	run;


signoff; 

%put "All sessions have completed   %sysfunc(time(),time11.2)";


   
