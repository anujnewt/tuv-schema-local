create or replace procedure labconf.utils_handleerror (errorcode numeric,msg varchar) as $body$
begin 

/* dmap converted statement start */
raise exception '%',  concat(errorcode, ':', msg)  using errcode = '45002';/* dmap converted statement end */end;
$body$
language plpgsql
;
