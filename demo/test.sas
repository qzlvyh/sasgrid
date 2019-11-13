

proc sql;
  create table mygrid.newdata2 as
  select * from sashelp.cars;
quit;

data _null_;
	*sleep for 30 seconds*;
	call sleep(30000);
run;
data 
data mygrid.revised;
set mygrid.newdata;
if type = 'Wagon' then delete;
run;

