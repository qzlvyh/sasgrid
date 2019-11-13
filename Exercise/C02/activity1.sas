/* Chapter 2 Activity */


%put "Step is running on &syshostname at %sysfunc(time(),time11.2) as grid job id %sysget(LSB_JOBID)";

proc means data=sashelp.cars;
   var mpg_highway;
   class origin type;
run;
