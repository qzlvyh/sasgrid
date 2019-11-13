/* Chapter 2 Exercise 4 - Parallel processing */

/* This program creates 2 working tables that are summarized and then joined back together. 
   The PROC SUMMARY steps can run in parallel. 

SOLUTION with all syntax and logic errors fixed.
*/

/* delete all data tables from the MYGRID library */
    proc datasets lib=MYGRID nolist kill;
    quit;	


%let rc=%sysfunc( grdsvc_enable( _all_, server=SASApp; jobname=jnvar ));

	data mygrid.domestic
		 mygrid.foreign;
	   set sashelp.cars;
	   if origin = 'USA' then output mygrid.domestic;
	   else output mygrid.foreign;
	run;
	   	 
%let jnvar=SESS1;
signon sess1;

rsubmit sess1 wait=no;

	proc summary data=mygrid.domestic;
	  class type;
	  id origin;
	  var mpg_city msrp;
	  output out=mygrid.domestic_stats mean=;
	run;	

endrsubmit;

%let jnvar=SESS2;
signon sess2;

rsubmit sess2 wait=no;

	proc summary data=mygrid.foreign;
	  class type;
	  var mpg_city msrp;
	  output out=mygrid.foreign_stats mean=;
	run;	

endrsubmit;


WAITFOR _ALL_ sess1 sess2;

	data mygrid.all_detail
	     mygrid.all_summary;
	  set mygrid.domestic_stats  mygrid.foreign_stats;
	  if _type_ = 0 then output mygrid.all_summary;
	  else output mygrid.all_detail;
	run;	


/* Signoff all sessions when they are finished processing */
signoff _ALL_;
