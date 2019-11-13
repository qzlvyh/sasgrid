/* Chapter 2 - demo - parallel  */
/* submit code to separate Grid sessions for simultaneous execution */


/* enable Grid resources */
%let rc=%sysfunc(grdsvc_enable(_all_, server=SASApp; jobname=jnvar));

libname orion '/opt/sas/data/OrionStar/ordetail';
	
	data mygrid.curr_emps;
	   set orion.employees;
	   Years=year(today())-year(hiredate);
	   Age=year(today())-year(birthdate);
	run;


/* signon and remote submit to Grid session 1 */
%let jnvar=p_freq;
signon session1 connectwait=no signonwait=no; 

rsubmit session1;

	proc freq data=mygrid.curr_emps;
	   tables department gender;
	run;
	data _null_;
	*sleep for 1 minutes*;
	call sleep(60000);
	run;

endrsubmit;

%let jnvar=p_print;
signon session2 connectwait=no signonwait=no; /* session 2*/
rsubmit session2; 

	proc print data=mygrid.curr_emps(obs=10);
	   var Employee_Name Salary Years Age;
	run;
	
endrsubmit;

%let jnvar=p_means;
signon session3 connectwait=no signonwait=no; /* session 3*/
rsubmit session3;

	proc means data=mygrid.curr_emps mean max;
	   var age years;
	   class job_title;
	run;
	
endrsubmit;

waitfor _ALL_ session1 session2 session3;

signoff _all_; 

%put "All sessions have completed   %sysfunc(time(),time11.2)";
   
