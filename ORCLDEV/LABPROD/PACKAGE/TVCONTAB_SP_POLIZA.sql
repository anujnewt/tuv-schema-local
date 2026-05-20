create or replace procedure labprod.tvcontab_sp_poliza (idepro labprod.glcoargu.arg_idepro%type, idepcc labprod.glcoargu.arg_idepcc%type, keyusu labprod.glcoargu.arg_keyusu%type, fecini labprod.glcoargu.arg_fecini%type, horini labprod.glcoargu.arg_horini%type) as $body$
declare
-- pgv moved types start
--dmap moved type current package tvcontab;
--dmap moved type current package tvcontab;
current_setting('tvcontab.args')::TVCONTAB_argumentos 		TVCONTAB_argumentos;
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
proceso_temp numeric;
periodo_temp varchar;
nomina_temp numeric;
dr_ciaori_temp varchar;
dr_ciades_temp varchar;
dr_concep_temp varchar;
dr_cta_temp varchar;
dr_scta_temp varchar;
madre_temp numeric;
hija_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCONTAB');
--dmap conversion comment: gtt declaration added
current_setting('tvcontab.args')::TVCONTAB_argumentos.idepro := idepro;  current_setting('tvcontab.args')::TVCONTAB_argumentos.idepcc := idepcc;  current_setting('tvcontab.args')::argumentos.keyusu := keyusu;  current_setting('tvcontab.args')::argumentos.fecini := fecini;  current_setting('tvcontab.args')::argumentos.horini := horini;
select arg_pvalor into strict proceso_temp from labprod.glcoargu
where arg_idepro = idepro and arg_idepcc = idepcc and arg_keyusu = keyusu
and arg_fecini = fecini and arg_horini = horini and arg_keycam = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'ARGPRO', 'varchar2', 'N')::varchar;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number',(proceso_temp)::text, 'N');
select arg_pvalor into strict periodo_temp from labprod.glcoargu
where arg_idepro = idepro and arg_idepcc = idepcc and arg_keyusu = keyusu
and arg_fecini = fecini and arg_horini = horini and arg_keycam = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'ARGPER', 'varchar2', 'N')::varchar;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCONTAB', 'PERIODO', 'varchar2',(periodo_temp)::text, 'N');
periodo_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar;
proceso_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric;
call tvcontab_sp_contable(proceso_temp, periodo_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number',(proceso_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCONTAB', 'PERIODO', 'varchar2',(periodo_temp)::text, 'N');end;
$body$
language plpgsql
;
