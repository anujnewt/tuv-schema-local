create or replace  function  labprod.tvcdesaf_local_existe_prestamo (cveref labprod.nmlopres.pre_refere%type, keyemp labprod.nmlopres.pre_keyemp%type, keycon labprod.nmlopres.pre_keycon%type, tipact numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
peract_temp varchar;
porcen_temp numeric;
cuofij_temp numeric;
totafi_temp numeric;
capdes_temp numeric;
fecini_temp timestamp(0);
keypre_temp numeric;
impdes_temp numeric;
total_temp numeric;
perini_temp varchar;
impdes_validado_temp numeric;
prueba_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCDESAF_LOCAL');
--dmap conversion comment: gtt declaration added
if tipact = 14 then
select count(*) into strict total_temp from labprod.nmlopres
where pre_refere = cveref and pre_keyemp = keyemp
and pre_ca2aux = 1 and pre_keycon = keycon
and pre_status = 2;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER',(total_temp)::text, 'N');
elsif tipact = 2034151 then
select count(*) into strict total_temp from labprod.nmlopres
where pre_refere = cveref and pre_keyemp = keyemp
and pre_ca2aux = 1 and pre_keycon = keycon
and pre_status = 1;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER',(total_temp)::text, 'N');
else
select count(*) into strict total_temp from labprod.nmlopres
where pre_refere = cveref and pre_keyemp = keyemp
and pre_ca2aux = 1 and pre_keycon = keycon;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER',(total_temp)::text, 'N');
end if;
return dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER', 'N')::numeric;end;
$body$
language plpgsql
;
