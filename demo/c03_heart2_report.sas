
%let fileloc = /opt/sas/data/&sysuserid./log_lst;

proc printto log="&fileloc./heart2_report.log"
             print="&fileloc./heart2_report.lst"
             new;

title "Cause of Death by Gender";
proc freq data=mygrid.heart_d;
  label sex="Gender";
  label deathcause="Cause of Death";
  table sex*deathCause;
run;  

proc printto;

data _null_;
	*sleep for 30 seconds*;
	call sleep(30000);
	run;
