
/* sample code to run LSF line commands from a SAS program */
 
%let command= bjobs -a ;

filename cmdout pipe "&command" 
     LRECL=2000;

data _null_ ;
  infile cmdout;
  input;
  file print notitles;
  put _infile_;
run;





 