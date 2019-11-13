/* Chapter 2 Exercise 7 - Reusable grid sessions */


%let rc=%sysfunc( grdsvc_enable( _all_, server=SASApp; jobname=jnvar; ));
%let jnvar=Session_reuse;

%let nSess=2;

%initVars(&nSess);

signon session1 CMACVAR=mySignonVar1;
signon session2 CMACVAR=mySignonVar2;

%waitForAvailableSession(&nSess);

rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	proc print data=sashelp.cars;
		where model = 'SUV';
	run;	
endrsubmit;

%waitForAvailableSession(&nSess);

rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	proc print data=sashelp.cars;
		where type = 'Wagon';
	run;	
endrsubmit;


%waitForAvailableSession(&nSess);

rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	proc print data=sashelp.cars;
		where type = 'Truck';
	run;	
endrsubmit;


%waitForAvailableSession(&nSess);

rsubmit session&openSessID WAIT=NO CMACVAR=myRsubmitVar&openSessID;
	proc print data=sashelp.cars;
		where type = 'Sports';
	run;	
endrsubmit;


signoff _ALL_;
