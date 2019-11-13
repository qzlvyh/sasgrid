/* Chapter 3 Demo program to be submitted via SASGSUB */


libname orion meta library='Orion';

data us_emps;
   set orion.employees;
   where country eq 'US';

   Years=year(today())-year(hiredate);
   Age=year(today())-year(birthdate);
run;


proc freq data=us_emps;
     tables department gender age;
	 title 'US Employees';
run;	