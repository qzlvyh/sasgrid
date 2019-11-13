/* Chapter 3 - Analyzing programs with macros. 

This program calls a macro that prepares the data for the PROC steps. 
The macro autocall library is /opt/sas/Workshop/Macro.
	
*/


/* delete all data from personal temporary data share */

proc datasets lib=mygrid kill nodetails;
run;

libname orion '/opt/sas/data/OrionStar/ordetail';

%include '/opt/sas/Workshop/Demo/getdata.sas';       


proc freq data=mygrid.eur_emps;
   tables job_title*department country / crosslist nocum norow nocol nopercent;
run;

proc freq data=mygrid.us_emps;
   tables job_title*department gender / crosslist nocum norow nocol nopercent;
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
