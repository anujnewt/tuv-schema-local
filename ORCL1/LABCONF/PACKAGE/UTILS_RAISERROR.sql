create or replace procedure labconf.utils_raiserror (errorcode numeric,msg varchar) as $body$
begin 

/* dmap converted statement start */
perform dbms_output.put_line( concat(errorcode, ':', msg)) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
