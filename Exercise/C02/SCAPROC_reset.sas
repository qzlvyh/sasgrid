/* The code generated with the SCAPROC procedure uses macro variables that need to be reset 
   when running generated code multiple times in the same SAS session.

   This statement will deleted the macro variables that control the remote setup. These 
   macro variables prevent the %scaproc_remote_setup macro from executing more than once per 
   remote session. 

*/

%SYMDEL scaproc_libname_set_sess1  scaproc_libname_set_sess2
		scaproc_libname_set_sess3  scaproc_libname_set_sess4
		scaproc_libname_set_sess5  scaproc_libname_set_sess6
		scaproc_libname_set_sess7  scaproc_libname_set_sess8
		/nowarn;