/* Chapter 2 - Exercise 2 - running a program on the grid   */

/****************
 Processing overview:

  Two reports are being produced. Both reports are independent and could run at the same time.
  
  Add statements to run one report in a separate grid session and the other in the SAS Studio parent grid session. 
  
*/  


title;
title1 "Number of US Models Available by Origin and Type";
%put "US Model Report is running on &syshostname at %sysfunc(time(),time11.2) as grid job id %sysget(LSB_JOBID)";

proc report data=SASHELP.CARS;
  where origin = 'USA';
   columns origin type;
   define origin / group;
   define type / across;
run;


title;
title1 "Number of Foreign Models Available by Origin and Type";
%put "Foreign Model Report is running on &syshostname at %sysfunc(time(),time11.2) as grid job id %sysget(LSB_JOBID)";

proc report data=SASHELP.CARS;
  where origin NOT = 'USA';
   columns origin type;
   define origin / group;
   define type / across;
run;
