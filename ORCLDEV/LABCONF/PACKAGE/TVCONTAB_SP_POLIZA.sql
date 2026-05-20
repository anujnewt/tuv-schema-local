create or replace procedure labconf.tvcontab_sp_poliza (idepro labconf.glcoargu.arg_idepro%type, idepcc labconf.glcoargu.arg_idepcc%type, keyusu labconf.glcoargu.arg_keyusu%type, fecini labconf.glcoargu.arg_fecini%type, horini labconf.glcoargu.arg_horini%type) as $body$
declare
-- pgv moved types start
--dmap moved type current package tvcontab;
periodo labconf.nmlohism.his_keyper%type;
--dmap moved type current package tvcontab;
proceso	labconf.nmlohism.his_keypro%type;
--dmap moved type current package tvcontab;
--dmap moved type current package tvcontab;
current_setting('tvcontab.args')::TVCONTAB_argumentos 		TVCONTAB_argumentos;
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
dr_ciaori_temp varchar;
dr_ciades_temp varchar;
dr_cta_temp varchar;
dr_scta_temp varchar;
madre_temp numeric;
hija_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'TVCONTAB');
--dmap conversion comment: gtt declaration added
current_setting('tvcontab.args')::TVCONTAB_argumentos.idepro := idepro;  current_setting('tvcontab.args')::TVCONTAB_argumentos.idepcc := idepcc;  current_setting('tvcontab.args')::argumentos.keyusu := keyusu;  current_setting('tvcontab.args')::argumentos.fecini := fecini;  current_setting('tvcontab.args')::argumentos.horini := horini;
select arg_pvalor into strict proceso from labconf.glcoargu
where arg_idepro = idepro and arg_idepcc = idepcc and arg_keyusu = keyusu
and arg_fecini = fecini and arg_horini = horini and arg_keycam = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'ARGPRO', 'varchar2', 'N')::varchar;
select arg_pvalor into strict periodo from labconf.glcoargu
where arg_idepro = idepro and arg_idepcc = idepcc and arg_keyusu = keyusu
and arg_fecini = fecini and arg_horini = horini and arg_keycam = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'ARGPER', 'varchar2', 'N')::varchar;
call tvcontab_sp_contable(proceso, periodo);end;
$body$
language plpgsql
;
