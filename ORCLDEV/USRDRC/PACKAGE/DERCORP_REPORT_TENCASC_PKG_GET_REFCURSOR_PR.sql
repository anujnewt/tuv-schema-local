create or replace procedure usrdrc.dercorp_report_tencasc_pkg_get_refcursor_pr ( pistempresa numeric) as $body$
declare
rggetdescchilds record;
rggetchilds record;
-- pgv moved types start
-- pgv moved types end
-- declaracion de variables
lrginrow dercorp_reporte_tencasc_tmp%rowtype;
-- declaracion de cursores
cur_get_childs cursor(piidempresa numeric)
for
select  id_empresa,coalesce(val_c5,0) val_c5
from    dercorp_metatbl_tab
where   id_flex_tbl = (select  id_flex_tbl
from    dercorp_flex_tbls_tab
where   cod_flex    = 'FLEX7')
and id_empresa != piidempresa
and val_c1      = (select  id_catalogo_valor
from    dercorp_add_campo_cat_val_tab
where   id_catalogo = 40
and val_cat_val = (select  nom_empresa
from    dercorp_empresa_tab
where   id_empresa = piidempresa))
--nava
and
(val_c5)::numeric  > (select
(val_config)::numeric
from app_config_tab
where
cod_config = 'MIN_P_TC')
-- inicio codigo agregado 13-oct-15 jfps
and not exists (
select 1
from   usrdrc.dercorp_reporte_tencasc_tmp
where  des_dato1 = id_empresa
and    des_dato4 = piidempresa
)
-- fin codigo agregado  13-oct-15 jfps
;
cur_get_desc_childs cursor(piidempresa numeric)
for
select  id_empresa, cve_empresa, nom_empresa
from    dercorp_empresa_tab
where   id_empresa = piidempresa;
--dmap conversion comment: global temp variables moved as local temp variables
gincountarr_temp numeric;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('USRDRC', 'DERCORP_REPORT_TENCASC_PKG');
--dmap conversion comment: gtt declaration added
--gincountarr := 0;
-- traemos los datos requeridos
for rggetchilds in select * from cur_get_childs(pistempresa) loop
for rggetdescchilds in select * from cur_get_desc_childs(rggetchilds.id_empresa) loop
-- imprimimos informacion
--dercorp_report_tencasc_pkg_print_message_pr(dbms,         row_num: ||to_char(gincountarr+1));
--dercorp_report_tencasc_pkg_print_message_pr(dbms,      id_empresa: ||rggetdescchilds.id_empresa);
--dercorp_report_tencasc_pkg_print_message_pr(dbms,     cve_empresa: ||rggetdescchilds.cve_empresa);
--dercorp_report_tencasc_pkg_print_message_pr(dbms,     nom_empresa: ||rggetdescchilds.nom_empresa);
--dercorp_report_tencasc_pkg_print_message_pr(dbms, from id_empresa: ||pistempresa);
lrginrow.des_dato1   := rggetdescchilds.id_empresa;
lrginrow.des_dato2   := rggetdescchilds.cve_empresa;
lrginrow.des_dato3   := rggetdescchilds.nom_empresa;
lrginrow.des_dato4   := pistempresa;/* dmap converted statement start */
lrginrow.des_dato5   := rtrim(ltrim(to_char(rggetchilds.val_c5::text,'999.999999')));/* dmap converted statement end */
-- insertamos en la temporal
call dercorp_report_tencasc_pkg_insert_row_pr(lrginrow);
-- iniciamos la recursividad
call dercorp_report_tencasc_pkg_get_refcursor_pr( pistempresa   => rggetchilds.id_empresa);
end loop;
call dmap_extension.p_dmap_set_pkg_var('USRDRC' , 'DERCORP_REPORT_TENCASC_PKG', 'GINCOUNTARR', 'NUMBER',(dmap_extension.f_dmap_get_pkg_var('USRDRC' , 'DERCORP_REPORT_TENCASC_PKG', 'GINCOUNTARR', 'NUMBER', 'N')::numeric +1)::text, 'N');
end loop;end;
$body$
language plpgsql
;
