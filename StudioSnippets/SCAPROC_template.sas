/* SCAPROC template */

proc scaproc;
	record  <path and file name > /* Code Analyzer Comments*/
	grid    <path and file name > /* Grid Exploiting Code */
	resource "SASApp";            /* SAS Server */
run;

  <SAS program code >;
  
  
proc scaproc;
	write;
run;

/* optional statement to handle use of implicit WORK library */
options user=  <path name> or <libref>;   
