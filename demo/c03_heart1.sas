
%let fileloc = /opt/sas/data/&sysuserid./log_lst;

proc printto log="&fileloc./heart1_data.log"
             new;

proc sql;
  create table mygrid.heart_d as 
  select * from sashelp.heart
  where status = 'Dead';
  
  create table mygrid.heart_a as 
  select * from sashelp.heart
  where status = 'Alive';
  
quit;

proc printto;

data _null_;
	*sleep for 15 seconds*;
	call sleep(15000);
	run;
