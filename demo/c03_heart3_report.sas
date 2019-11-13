%let fileloc = /opt/sas/data/&sysuserid./log_lst;

proc printto log="&fileloc./heart3_report.log"
             print="&fileloc./heart3_report.lst"
             new;
             
title "Smoking Status by Gender";
proc freq data=mygrid.heart_a;
  label sex="Gender";
  table sex*smoking_status;
run;  

proc printto;

data _null_;
	*sleep for 30 seconds*;
	call sleep(30000);
run;