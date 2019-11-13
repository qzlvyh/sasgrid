/* Chapter 3 Exercise 3 - Parallel processing */


/************
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


  /* split the data */
	data mygrid.domestic
	     mygrid.foreign;
	   set sashelp.cars;
	   if origin = 'USA' then 
	     do; group='Domestic';
                 output mygrid.domestic;
             end;
	   else 
	     do; group='Foreign';
                 output mygrid.foreign;
             end;
	run;

  /* use parallel processing to summarize both datasets at the same time */	   	 

   signon sess1;

   rsubmit sess1 wait=n;

	proc summary data=mygrid.domestic;
	  class type;
	  id group;
	  var mpg_city mpg_highway msrp;
	  output out=mygrid.domestic_stats mean=;
	run;	

   endrsubmit;


   signon sess2;

   rsubmit sess2 wait=n;


	proc summary data=mygrid.foreign;
	  class type;
          id group;
	  var mpg_city mpg_highway msrp;
	  output out=mygrid.foreign_stats mean=;
	run;
	
   endrsubmit;

   waitfor _ALL_  sess1 sess2;


  /* combine the data and create a report */

	data mygrid.all_summary;
	  set mygrid.domestic_stats  mygrid.foreign_stats;
	  if _type_ = 1 then output mygrid.all_summary;
	run;	

        title 'Average MPG and MSRP';
	proc report data=mygrid.all_summary;
	 column type group,mpg_city group,mpg_highway group,msrp;
	 define type /group 'Model Type';
	 define group /across 'Origin';
	 define mpg_city / analysis format=4.1;
	 define mpg_highway / analysis format=4.1;
	run;


/* Signoff all sessions when finished processing */

signoff _all_;

