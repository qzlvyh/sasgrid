proc print data=sashelp.cars ;
run ;

data _null_;
set sashelp.cars;
file 'cars.txt';
put origin type;
run;

