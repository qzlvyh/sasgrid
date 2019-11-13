/* Chapter 3 - Analyzing programs with macros. 

This program calls a macro that prepares the data for the PROC steps. 
The EXPANDMACROS option will evaluate the macro code during the analysis
Macro programs are on Linux in the /opt/sas/Workshop/Macro directory.
	
*/


/* delete all data from personal temporary data share */
proc datasets lib=mygrid kill nodetails;
run;

libname orion '/opt/sas/data/OrionStar/ordetail';

%m_getdata;       


proc freq data=mygrid.eur_emps;
   tables department*job_title country / crosslist nocum norow nocol nopercent;
run;

proc freq data=mygrid.us_emps;
   tables department*job_title gender / crosslist nocum norow nocol nopercent;
run;

proc means data=mygrid.eur_emps mean min;
   var salary;
   class hiredate;
   format hiredate year4.;
run;

proc means data=mygrid.us_emps mean min;
   var salary;
   class hiredate;
   format hiredate year4.;
run;
