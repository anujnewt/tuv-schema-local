create or replace procedure labconf."sp_sips_orac_empl2"  (vn_keyemp integer, vp_nomemp varchar, vp_cvesex varchar, vp_regrfc varchar, vp_recurp varchar, vp_regims varchar, vp_fecing timestamp(0), vp_tipemp varchar, vp_fecbaj timestamp(0), vp_status integer, vo_nomemp varchar, vo_cvesex varchar, vo_regrfc varchar, vo_recurp varchar, vo_regims varchar, vo_fecing timestamp(0), vo_tipemp varchar, vo_fecbaj timestamp(0), vo_status integer, tipo varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vn_apelli varchar(150);
vn_nomemp varchar(150);
vn_cvesex varchar(1);
vn_fecnac timestamp(0);
vn_tipemp varchar(16);
vn_status varchar(16);
vn_keypro integer;
--igneos.i --necesita variable temporal en oracle
temporal timestamp(0);
begin
select emp_keypro into strict vn_keypro
from   nmcoempl where emp_keyemp = vn_keyemp;/* dmap converted statement start */
if vn_keypro = 81 or vn_keypro = 17 or vn_keypro = 18 or vn_keypro = 3  or vn_keypro = 77 or vn_keypro = 8  or vn_keypro = 66 then
if tipo = 'IN' then
select concat( trim(both sp_delimitador(emp_nomemp,'/',1)), '/' , trim(both sp_delimitador(emp_nomemp,'/',2))) ,
trim(both sp_delimitador(emp_nomemp,'/',3)), case when emp_cvesex='1' then 'M'  else 'F' end ,
sp_fecnac(emp_regrfc), case when emp_tipemp='1' then 'CONFIANZA'  else 'SINDICALIZADO' end
into strict
vn_apelli, vn_nomemp, vn_cvesex, vn_fecnac, vn_tipemp
from nmcoempl
where emp_keyemp=vn_keyemp;/* dmap converted statement end */
insert into com_sips_orac_empl
values (0,'','',vn_apelli,vn_nomemp,vn_tipemp,vn_cvesex,vp_regrfc, vp_recurp,vp_regims,vp_fecing,vn_fecnac,'PQH_MX',81,'','','EMP');/* dmap converted statement start */
elsif  vp_nomemp != vo_nomemp or vp_cvesex != vo_cvesex or vp_recurp != vo_recurp or vp_regims != vo_regims or
vp_fecing != vo_fecing or vp_tipemp != vo_tipemp or vp_status != vo_status or vp_fecbaj != vo_fecbaj then
select concat( trim(both sp_delimitador(emp_nomemp,'/',1)), '/', trim(both sp_delimitador(emp_nomemp,'/',2))) ,
trim(both sp_delimitador(emp_nomemp,'/',3)), case when emp_cvesex='1' then 'M'  else 'F' end ,
sp_fecnac(emp_regrfc), case when emp_tipemp='1' then 'CONFIANZA'  else 'SINDICALIZADO' end , trim(both case when emp_status=1 then ''  else 'EX_EMP' end )
into strict
vn_apelli, vn_nomemp, vn_cvesex, vn_fecnac, vn_tipemp, vn_status
from nmcoempl
where emp_keyemp=vn_keyemp;/* dmap converted statement end */
if vn_status = 'EMP' then
temporal := null;
else
temporal := vp_fecbaj;
end if;
insert into com_sips_orac_empl
values (0,'','',vn_apelli,vn_nomemp,vn_tipemp,vn_cvesex,vp_regrfc,vp_recurp,vp_regims,vp_fecing,vn_fecnac,'PQH_MX',81,'', temporal,vn_status);
elsif vp_regrfc != vo_regrfc then
insert into com_sips_orac_bita
values ('com_sips,orac_empl', vo_regrfc,vp_regrfc,vn_keyemp, clock_timestamp(), 'RFC ES EL CAMPO LLAVE Y CAMBIO',0,'');
end if;
end if;end;
$body$
language plpgsql
;
