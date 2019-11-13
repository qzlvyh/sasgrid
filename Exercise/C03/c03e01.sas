
title;
title1 "Average Miles per Gallon - City";
Footnote "Generated on &syshostname with OS process id &sysjobid and gird job id %sysget(LSB_JOBID)";

proc tabulate
   data=SASHELP.CARS;

   var MPG_City;
   class Type /order=unformatted missing;
   class Make /order=unformatted missing;
   class Origin /order=unformatted missing;
   
   table Make * MPG_City* Mean, Origin;
run;

