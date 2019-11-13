/* Chapter 4 Exercise 5 - Parallel processing */


/************

     SOLUTION - example program of splitting data, processing in parallel, and combining for a report. 


*************/


  /* delete all data tables from previous jobs */
    proc datasets lib=mygrid nolist kill;
    quit;	


%let rc=%sysfunc( grdsvc_enable( _all_, server=SASApp;));

/* start one grid sesion to be used multiple times */

   signon sess1;


/* split the data using parallel steps */

   rsubmit sess1 wait=n;
 
	data mygrid.domestic;
	   set sashelp.cars;
	   if origin = 'USA'; 
	run;
   endrsubmit;

	data mygrid.foreign;
	   set sashelp.cars;
	   if origin NOT = 'USA';
	run;
	   	 
   waitfor sess1; 

/* process the data in parallel */

   rsubmit sess1 wait=n;

	proc summary data=mygrid.domestic;
	  class type;
	  id origin;
	  var mpg_city msrp;
	  output out=mygrid.domestic_stats mean=;
	run;	

   endrsubmit;

	proc summary data=mygrid.foreign;
	  class type;
	  var mpg_city msrp;
	  output out=mygrid.foreign_stats mean=;
	run;
	

   waitfor sess1; 

/* Signoff when finished parallel processing - release the job slot */

   signoff;

	data mygrid.all_summary;
	  set mygrid.domestic_stats  mygrid.foreign_stats;
	  if _type_ = 1 then output mygrid.all_summary;
	run;	

    title 'Average MPG and MSRP';
	proc report data=mygrid.all_summary;
	 column type origin,mpg_city origin,msrp;
	 define type /group 'Model Type';
	 define origin /across 'Origin';
	 define mpg_city / analysis format=4.1;
	run;



