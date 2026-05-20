create or replace  function  usrsiho."fn_hpgrvare4"  (vs_sts_rec smallint, vs_sts_fon smallint, vs_cve_ban varchar, vn_longi smallint ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- sistema  : rh-2000  c/s
-- modulo   : nomina de honorarios(ho)
-- programa : sp_ hpgrvare1
--            definicion de tipo de pago
-- autor    : veronica vazquez rodriguez
-- fecha    : 29 de octubre de 1999
-- modifico : claudia torres r. 29.nov.99
-- modifico : emilio pulido rangel 25.mzo.03
-- en el if donde retorna 4 vn_longi tenia <16 y le puse <12
begin
-- define situacion
if vs_sts_rec = 1 and vs_sts_fon = 1 then
return 1;
elsif vs_sts_rec = 1 and vs_sts_fon in (0,2) then
return 2;
elsif  vs_cve_ban = '002' and vs_sts_rec = 3 and vs_sts_fon in (0,3) and vn_longi =16 then
return 3;
elsif (vs_cve_ban <> '002' and vs_sts_rec = 3 and vs_sts_fon = 0)
or (vs_cve_ban = '002' and vs_sts_rec = 3 and vs_sts_fon in (0,3) and vn_longi =18) then
return 4;
else
return 0;
end if;end;
--dmap converted function completed
$body$
language plpgsql
stable;
