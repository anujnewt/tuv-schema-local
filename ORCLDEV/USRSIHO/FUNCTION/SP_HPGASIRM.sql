create or replace  function  usrsiho."sp_hpgasirm"  (vn_sts_con numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
if vn_sts_con = 1 then
return 'FIRMADO';
elsif vn_sts_con = 2 then
return 'NO FIRMADO';
else
return 'SIN CONTRATO';
end if;end;
--dmap converted function completed
$body$
language plpgsql
stable;
