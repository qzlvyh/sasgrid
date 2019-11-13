/* Chapter 2 - Level 2 Exercise 10 - Using PROC SCAPROC */

/* Add the PROC SCAPROC steps to generate grid-enabled code with parallel processing. 
   Other changes may be needed to this program to allow SCAPROC to generated executable
   code.
*/

proc scaproc;
	record  '/opt/sas/Workshop/Exercise/C02/comments.txt'  /* Code Analyzer Comments*/
	grid    '/opt/sas/Workshop/Exercise/C02/grid_out_10.sas' /* Grid Exploiting Code */
	resource "SASApp";            /* SAS Server */
run;

options user=mygrid;

/* SCAPROC GLOBAL BEGIN */
libname orion '/opt/sas/data/OrionStar/ordetail';
/* SCAPROC GLOBAL END */

proc sql; 
	create table eur_emps as
	select * 
	from orion.employees 
	where country ne'US';
quit;

proc sql;    
	create table us_emps as
	select *
	from orion.employees
	where country = 'US';
	
quit;

proc freq data=eur_emps;
   tables department*job_title country / crosslist nocum norow nocol nopercent;
   title 'Counts of European Employees by Department/Job Title and Country';
run;

proc freq data=us_emps;
   tables department*job_title gender / crosslist nocum norow nocol nopercent;
   title 'Counts of US Employees by Department/Job Title and Gender';
run;

proc means data=eur_emps mean min;
   var salary;
   class hiredate;
   format hiredate year4.;
   title 'Salaries  of European Employees by Year Hired';
run;

proc means data=us_emps mean min;
   var salary;
   class hiredate;
   format hiredate year4.;
   title 'Salaries of US Employees by Year Hired';
run;

proc scaproc;
	write;
run;

