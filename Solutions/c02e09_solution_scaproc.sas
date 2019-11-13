/* Chapter 2 - Exercuse 9 - SCAPROC */
/* 
 *   SOLUTION 
 * 
 */


proc scaproc;
	record '/opt/sas/Workshop/Demo/Comments_out.sas' /* Code Analyzer Comments*/
	grid '/opt/sas/Workshop/Demo/Grid_out.sas'       /* Grid Exploiting Code */
	resource "SASApp";                                    /* SAS Server */
run;

options user=mygrid;
/* SCAPROC GLOBAL BEGIN */
libname orion '/opt/sas/data/OrionStar/ordetail';
/* SCAPROC GLOBAL END */

data us_cust;
   set orion.customer;
   where country='US';
   age = intck('YEAR',birth_date,today());
run;

data non_us;
   set orion.customer;
   where country ne 'US';
   age = intck('YEAR',birth_date,today());
run;

proc freq data=non_us;
   tables age*gender gender;
run;

proc freq data=us_cust;
   tables age*gender gender;
run;

proc means data=us_cust;
   var age;
   class customer_type_ID;
run;

proc means data=non_us;
   var age;
   class customer_type_ID;
run;

proc freq data=non_us;
	tables country;
run;

proc scaproc;
	write;
run;
