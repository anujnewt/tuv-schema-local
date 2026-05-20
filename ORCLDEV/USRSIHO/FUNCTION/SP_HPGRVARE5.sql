create or replace  function  usrsiho."sp_hpgrvare5"  (vs_cve_ban varchar, vs_sts_fon numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- sistema  : rh-2000  c/s
-- modulo   : nomina de honorarios(ho)
-- programa : sp_ hpgrvare2
--            definicion de tipo de pago
-- autor    : veronica vazquez rodriguez
-- fecha    : noviembre 1999
-- modifico : claudia torres rodriguez
-- define situacion
if vs_sts_fon = 1 then
return 'EFECTIVO';
else
if (vs_sts_fon = 0 and nullif(vs_cve_ban::text, '') is null)
or (vs_sts_fon = 2) then
return 'CHEQUES';
else
if vs_cve_ban like '002%'
and vs_sts_fon = 0 then
return 'BANAMEX';
else
if vs_cve_ban not like '002%'
and nullif(vs_cve_ban::text, '') is not null
and vs_sts_fon = 0 then
return 'OTROS BANCOS';
else
return 'INDEFINIDO';
end if;
end if;
end if;
end if;end;
--dmap converted function completed
$body$
language plpgsql
stable;
