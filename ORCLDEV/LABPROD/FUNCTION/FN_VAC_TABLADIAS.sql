create or replace  function  labprod."fn_vac_tabladias"  ( keypro integer , keyloc varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
keytab varchar(6);
begin
begin
select pam_folfin into strict keytab
from labprod.glcopams where pam_keypar = 'TTV' and pam_nompar = 'TABLA DE VACACIONES' and pam_cvesec = to_char(keypro);
exception
when no_data_found then
keytab:= null;
end;
return keytab;end;
--dmap converted function completed
$body$
language plpgsql
stable;
