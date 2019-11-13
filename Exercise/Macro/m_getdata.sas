
%macro m_getdata;
data mygrid.eur_emps;
   set orion.employees;
   where country ne'US';
run;

data mygrid.us_emps;
   set orion.employees;
   where country = 'US';
run;
%mend;
