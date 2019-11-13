/* Chapter 4 - exercise 2 - Analyzing a program in Enterprise Guide */

  

/* Library assignment for SASApp.ORION */
Libname ORION META  library="Orion";

PROC MEANS DATA=ORION.CUSTOMER 
	    FW=12 PRINTALLTYPES MAXDEC=1 NWAY
		MEAN MIN MAX NONOBS	MEDIAN;
	VAR Age;
	CLASS Country Gender /	ORDER=UNFORMATTED ASCENDING;
	WHERE Gender IN ('F','M');
RUN;


PROC FREQ DATA = ORION.CUSTOMER
	ORDER=INTERNAL;
	TABLES Age_Group * Gender /	NOCUM SCORES=TABLE ALPHA=0.05;
   WHERE Gender NOT = 'G';
RUN; 

