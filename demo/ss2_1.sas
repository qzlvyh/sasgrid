
/* submit a program to grid */

/* authenticate to the metadata server */
   options	metaserver=sasserver.demo.sas.com  
   		metaport=8561
		metapass=Metadata0
		metauser=Student;

/* 1. enable Grid resource */
%let rc=%sysfunc(grdsvc_enable(_all_,server=SASApp));

/* 2. signon to Grid */
signon session1;

/* 3. remote submit to Grid */
rsubmit session1;

	proc means data=sashelp.cars;
	   var mpg_city;
	   class origin type;
	run;

/* 4. end remote submit */
endrsubmit; 

/* 5. signoff Grid */
signoff session1; 
