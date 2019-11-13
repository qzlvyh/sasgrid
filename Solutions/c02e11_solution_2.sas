/* Chapter 2 - Challenge Exercise 11 - Using PROC SCAPROC */

/* SOULTION with %INCLUDE statement

*/

proc scaproc;
	record  '/opt/sas/Workshop/Exercise/C02/comments.txt'  /* Code Analyzer Comments*/
	grid    '/opt/sas/Workshop/Exercise/C02/grid_out_11_inc.sas' /* Grid Exploiting Code */
	resource "SASApp"  NOOPTIMIZE;             /* SAS Server */
run;


/* SCAPROC GLOBAL BEGIN */
libname orion '/opt/sas/data/OrionStar/ordetail';
/* SCAPROC GLOBAL END */

%include '/opt/sas/Workshop/Demo/getdata.sas';       

proc freq data=mygrid.eur_emps;
   tables department*job_title country / crosslist nocum norow nocol nopercent;
   title 'Counts of European Employees by Department/Job Title and Country';
run;

proc freq data=mygrid.us_emps;
   tables department*job_title gender / crosslist nocum norow nocol nopercent;
   title 'Counts of US Employees by Department/Job Title and Gender';
run;

proc means data=mygrid.eur_emps mean min;
   var salary;
   class hiredate;
   format hiredate year4.;
   title 'Salaries  of European Employees by Year Hired';
run;

proc means data=mygrid.us_emps mean min;
   var salary;
   class hiredate;
   format hiredate year4.;
   title 'Salaries of US Employees by Year Hired';
run;

proc scaproc;
	write;
run;

