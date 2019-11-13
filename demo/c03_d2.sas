/* redirecting output from inside the program */

%let fileloc = /opt/sas/data/&sysuserid./log_lst;

proc printto log="&fileloc./cars2.log"
             print="&fileloc./cars2.lst"
             new;

proc print data=sashelp.cars ;
 var model origin type;
run ;

proc means data=sashelp.cars;
	   var mpg_city;
	   class origin type;
	run;


proc printto;



