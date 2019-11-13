

	proc means data=sashelp.cars;
	   var mpg_city;
	   class origin type;
	run;

