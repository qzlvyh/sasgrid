/* Chapter 2 Exercise 8 - Reusable grid sessions */

/* Solution = process 12 months of data in 4 parallel sessions. 

*/ 

/* delete all data tables from the MYGRID library */
    proc datasets lib=MYGRID nolist kill;
    quit;	

%let rc=%sysfunc( grdsvc_enable( _all_, server=SASApp; jobname=jnvar ));

%let nSess=4;

%initVars(&nSess);

%let jnvar=Reuse1;
signon session1  CMACVAR=mySignonVar1;
%let jnvar=Reuse2;
signon session2  CMACVAR=mySignonVar2;
%let jnvar=Reuse3;
signon session3  CMACVAR=mySignonVar3;
%let jnvar=Reuse4;
signon session4  CMACVAR=mySignonVar4;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon1  as
	  select * 
	  from orion.orders
	  where month(order_date) = 1;
	quit;
endrsubmit;	


%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon2  as
	  select * 
	  from orion.orders
	  where month(order_date) = 2;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon3  as
	  select * 
	  from orion.orders
	  where month(order_date) = 3;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon4  as
	  select * 
	  from orion.orders
	  where month(order_date)= 4;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon5  as
	  select * 
	  from orion.orders
	  where month(order_date)= 5;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon6  as
	  select * 
	  from orion.orders
	  where month(order_date)= 6;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon7  as
	  select * 
	  from orion.orders
	  where month(order_date)= 7;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon8  as
	  select * 
	  from orion.orders
	  where month(order_date)= 8;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon9  as
	  select * 
	  from orion.orders
	  where month(order_date)= 9;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon10  as
	  select * 
	  from orion.orders
	  where month(order_date) = 10;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	libname orion '/opt/sas/data/OrionStar/ordetail';
	proc sql;
	 create table mygrid.mon11  as
	  select * 
	  from orion.orders
	  where month(order_date) = 11;
	quit;
endrsubmit;	
;

%waitForAvailableSession(&nSess);
rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
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
