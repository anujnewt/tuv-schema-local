create or replace  function  labprod.tvcdesaf_local_existe_afiliacion (keyemp labprod.nmlodfij.dfi_keyemp%type, keycon labprod.nmlodfij.dfi_keycon%type, keypro labprod.nmlodfij.dfi_keypro%type) returns TVCDESAF_LOCAL_afiliacion as $body$
declare
-- pgv moved types start
--dmap moved type current package tvcdesaf_local;
--dmap moved type current package tvcdesaf_local;
v_afiliacion TVCDESAF_LOCAL_afiliacion;
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
q_afiliacion record;
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCDESAF_LOCAL');
--dmap conversion comment: gtt declaration added
for q_afiliacion in (select dfi_cantid, dfi_import from labprod.nmlodfij where dfi_keyemp = keyemp and dfi_keycon = keycon and dfi_keypro = keypro)
loop
v_afiliacion.keycon := keycon;
v_afiliacion.porcen := q_afiliacion.dfi_cantid;
v_afiliacion.cuofij := q_afiliacion.dfi_import;
exit;
end loop;
return v_afiliacion;end;
$body$
language plpgsql
;
