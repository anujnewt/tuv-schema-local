create or replace  function  labprod."fn_vac_diasderecho"  ( keyemp numeric , fecing timestamp(0) , fecini timestamp(0) , keypro integer , tabdia varchar ) returns decimal as $body$
declare
-- pgv moved types start
-- pgv moved types end
diader decimal(10,2);
antiguedad decimal(10,2);
begin
antiguedad := months_between(fecini,fecing) / 12;/* dmap converted statement start */
perform dbms_output.put_line( concat('ANTIGUEDAD = ', antiguedad)) ;/* dmap converted statement end */
begin
select tab_eletre into strict diader
from labprod.nmlotabn
where tab_keytab = tabdia
and tab_eleuno <= antiguedad
and tab_eledos >= antiguedad  limit 1;
exception
when no_data_found then
diader := 0;
end;/* dmap converted statement start */
perform dbms_output.put_line( concat('DIADER = ', diader)) ;/* dmap converted statement end */
return diader;end;
--dmap converted function completed
$body$
language plpgsql
stable;
