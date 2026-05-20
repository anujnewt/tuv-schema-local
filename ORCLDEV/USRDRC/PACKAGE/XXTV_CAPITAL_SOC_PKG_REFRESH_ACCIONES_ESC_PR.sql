create or replace procedure usrdrc.xxtv_capital_soc_pkg_refresh_acciones_esc_pr (param_id_empresa numeric) as $body$
declare
i record;
-- pgv moved types start
-- pgv moved types end
var_formula                   varchar(150);
livalnominal                  numeric;
livalteonom                   numeric;
liidnominal                   numeric;
liidteoriconominal            numeric;
lstoutmsg                     varchar(4000);
--cursor para hacer la iteracion de cada fila
get_val_rows_cur cursor(param_id_empresa_cr  numeric)
for
select outer_q.*,
(select count(*)
from dercorp_metatbl_tab inner_q
where inner_q.id_empresa = outer_q.id_empresa
and inner_q.id_flex_tbl = outer_q.id_flex_tbl
and inner_q.val_c8 = outer_q.val_c8) count_grp
from dercorp_metatbl_tab outer_q
where outer_q.id_empresa = param_id_empresa_cr
and outer_q.id_flex_tbl = 7
order by outer_q.val_c8, outer_q.id_meta_row
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  val_valor
into strict    liidnominal
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 519
and     id_empresa = param_id_empresa
;
exception
when no_data_found then
liidnominal := 0;
end;
begin
/*select  val_valor
into    liidteoriconominal
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 1076
and     id_empresa = param_id_empresa
;
exception
when no_data_found then*/
liidteoriconominal := 0;
end;
for i in select * from get_val_rows_cur(param_id_empresa)
loop
/*
update dercorp_metatbl_tab set
val_c3 = replace(val_c3, ,,),
val_c4 = replace(val_c4, ,,)
where
id_empresa = param_id_empresa
and
id_flex_tbl = 7;
*/
var_formula := xxtv_capital_soc_pkg_formula_total_fn(param_id_empresa);
if var_formula = 'ACF_ACV_VN' then
--ecm 26 septiembre 2016
if liidnominal > 0 then
/*  select
(
select  to_number(replace(replace(val_cat_val, $, ), ,, ))
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = val_valor
)into   livalnominal
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 1076
;*/
begin
select (
select  (replace(replace(val_cat_val, '$', ''), ',', ''))::numeric
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = val_valor
)into   livalnominal
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 519;
exception
when data_exception then
livalnominal:=1;
end;
else
--ulr se asigno uno para cuando vn sea sin exp, n/a y valor desigual no afectar el capital social
livalnominal:=1;
--ecm 27 octubre 2015
/*select
(
select  to_number(replace(replace(val_cat_val, $, ), ,, ))
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = val_valor
)into   livalnominal
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 519
;*/
end if;
--valor acciones
--   = (acciones capital fijo + acciones capital variable) * valor nominal
update dercorp_metatbl_tab
set    val_c6 =
((coalesce(val_c3, 0))::numeric  + (coalesce(val_c4, 0))::numeric ) * livalnominal
where  1=1
and id_empresa = param_id_empresa
and id_flex_tbl = 7
and id_meta_row = i.id_meta_row
;
end if;
if var_formula = 'ACF_ACV' then
--valor acciones
--   = (acciones capital fijo + acciones capital variable)
update dercorp_metatbl_tab
set    val_c6 = ((coalesce(val_c3, 0))::numeric  + (coalesce(val_c4, 0))::numeric )
where  1=1
and    id_empresa = param_id_empresa
and    id_flex_tbl = 7
and    id_meta_row = i.id_meta_row
;
end if;
end loop;
call dercorp_captura_pkg_recalcular_cam_cap_ecs_pr(param_id_empresa,lstoutmsg);end;
$body$
language plpgsql
;
