/* Solution to submitting a program to SASGSUB from Enterprise Guide */


/* set macro variable to hold the SASGSUB command to submit the program */
%let command= &gsconfigdir./sasgsub -gridsubmitpgm /opt/sas/Workshop/Demo/c02_d3.sas;

/* change the SAS working directory */ 
x "cd /opt/sas/data/Jacques";

/* use a pipe to get the results of the command */
filename cmdout pipe "&command" LRECL=2000;


data _null_ ;
  infile cmdout;
  input;
  file print notitles;
  if _n_ = 1 then put "&command";
  put _infile_;
run;

%let command= bjobs;
filename cmdout pipe "&command" LRECL=2000;

data _null_ ;
  infile cmdout;
  input;
  file print notitles;
  if _n_ = 1 then put "&command";
  put _infile_;
run;

 