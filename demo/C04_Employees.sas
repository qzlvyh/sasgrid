/* Chapter 4 Exercise - Running a program in Enterprise Guide */

title1 "Salary by Department";
libname orion meta  library="Orion";;
proc means data= orion.employees
	    fw=12 printalltypes chartype maxdec=2 nway
		mean min max n;
	var salary;
	class department /	order=unformatted ascending;
    where employee_term_date is missing;
run;

title 'Count of Employees by Country and Starting Year';
libname orion meta  library="Orion";;
proc freq data=orion.employees;
   tables country*hiredate / nocol;
   format hiredate year4.;
run;

title 'Count of Employees by Country and Starting Year';
libname orion meta  library="Orion";;
proc corr data=orion.employees nosimple;
   var salary hiredate;
   format hiredate year4.;
run;
