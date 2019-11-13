/* Chapter 2 Exercise 8 - Reusable grid sessions */

/* This program process 12 months of data in parallel sessions. 

   Convert the program to use the %waitForAvailableSession macro to reduce the number of 
   grid sessions. 
*/ 

/* delete all data tables from the MYGRID library */
    proc datasets lib=MYGRID nolist kill;
    quit;	

%let rc=%sysfunc( grdsvc_enable( _all_, server=SASApp; jobname=jnvar ));

%let jnvar=sess1;
signon sess1;
rsubmit sess1 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon1  as
	  select * 
	  from orion.orders
	  where month(order_date) = 1;
	quit;
endrsubmit;	


%let jnvar=sess2;
signon sess2;
rsubmit sess2 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon2  as
	  select * 
	  from orion.orders
	  where month(order_date) = 2;
	quit;
endrsubmit;	
;

%let jnvar=sess3;
signon sess3;
rsubmit sess3 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon3  as
	  select * 
	  from orion.orders
	  where month(order_date) = 3;
	quit;
endrsubmit;	
;

%let jnvar=sess4;
signon sess4;
rsubmit sess4 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon4  as
	  select * 
	  from orion.orders
	  where month(order_date)= 4;
	quit;
endrsubmit;	
;

%let jnvar=sess5;
signon sess5;
rsubmit sess5 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon5  as
	  select * 
	  from orion.orders
	  where month(order_date)= 5;
	quit;
endrsubmit;	
;

%let jnvar=sess6;
signon sess6;
rsubmit sess6 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon6  as
	  select * 
	  from orion.orders
	  where month(order_date)= 6;
	quit;
endrsubmit;	
;

%let jnvar=sess7;
signon sess7;
rsubmit sess7 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon7  as
	  select * 
	  from orion.orders
	  where month(order_date)= 7;
	quit;
endrsubmit;	
;

%let jnvar=sess8;
signon sess8;
rsubmit sess8 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon8  as
	  select * 
	  from orion.orders
	  where month(order_date)= 8;
	quit;
endrsubmit;	
;

%let jnvar=sess9;
signon sess9;
rsubmit sess9 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon9  as
	  select * 
	  from orion.orders
	  where month(order_date)= 9;
	quit;
endrsubmit;	
;

%let jnvar=sess10;
signon sess10;
rsubmit sess10 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon10  as
	  select * 
	  from orion.orders
	  where month(order_date) = 10;
	quit;
endrsubmit;	
;

%let jnvar=sess11;
signon sess11;
rsubmit sess11 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon11  as
	  select * 
	  from orion.orders
	  where month(order_date) = 11;
	quit;
endrsubmit;	
;

%let jnvar=sess12;
signon sess12;
rsubmit sess12 wait=no;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon12  as
	  select * 
	  from orion.orders
	  where month(order_date) = 12;
	quit;
endrsubmit;	
;

signoff _all_;
