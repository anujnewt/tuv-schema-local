create or replace  function  labprod.tvautsaf_local_nombremunicipio (munemp labprod.nmcoempl.emp_munemp%type) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
banco_temp varchar;
bandera_temp integer;
nombre__temp varchar;
--dmap conversion comment: declaration boundary ends
catalogo record;
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF_LOCAL');
--dmap conversion comment: gtt declaration added
-- buscar equivalencia bancaria
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVAUTSAF_LOCAL', 'NOMBRE_', 'varchar2',(' ')::text, 'N');
for catalogo in (select pam_nompar from labprod.glcopams
where pam_keypar = 'MU' and pam_cvesec = munemp) loop
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVAUTSAF_LOCAL', 'NOMBRE_', 'varchar2',(catalogo.pam_nompar)::text, 'N');
exit;
end loop;
return dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVAUTSAF_LOCAL', 'NOMBRE_', 'varchar2', 'N')::varchar;end;
$body$
language plpgsql
;
