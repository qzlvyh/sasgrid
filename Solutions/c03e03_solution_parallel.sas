/* Chapter 3 Exercise 3 - Parallel processing */


/************

     SOLUTION - using fewer grid sessions and releasing grid session when no longer needed.


     Processing objective:
	1. split data to create a table for domestic cars and a separate table for foreign cars
	2. create a summary of the domestic car data
	3. create a summary of the foreigh car data
	4. combine the summary data into a single report

     Program notes:
	- The MYGRID library is assigned in an autoexec.sas program that runs when each workspace
	  server starts. It is automatically available to all grid sessions. The physical location
	  of the library is /opt/sas/data/<user id>
	- Prior to any processing the temporary data location is cleaned out to prevent old data 
	  from being used.

*************/


  /* delete all data tables from previous jobs */
    proc datasets lib=mygrid nolist kill;
    quit;	


%let rc=%sysfunc( grdsvc_enable( _all_, server=SASApp;));

	data mygrid.domestic
	     mygrid.foreign;
	   set sashelp.cars;
	   if origin = 'USA' then output mygrid.domestic;
	   else output mygrid.foreign;
	run;
	   	 

   signon sess1;

   rsubmit sess1 wait=n;

	proc summary data=mygrid.domestic;
	  class type;
	  id origin;
	  var mpg_city msrp;
	  output out=mygrid.domestic_stats mean=;
	run;	

   endrsubmit;

/* remove second SIGNON and RSUMBIT block - this will run in parent session */

	proc summary data=mygrid.foreign;
	  class type;
	  var mpg_city msrp;
	  output out=mygrid.foreign_stats mean=;
	run;
	

   waitfor _ALL_ sess1; 

/* Signoff all sessions when finished processing - release the job slot */

   signoff _ALL_;

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



