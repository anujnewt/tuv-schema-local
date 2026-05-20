create or replace procedure usrdrc.xxtv_capital_soc_pkg_recalcular_estructura_cs_pr ( param_id_empresa varchar ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_tab7_totalvaloracciones   numeric;
var_aplicacapitalfijo         numeric;
var_aplicacapitalvariable     numeric;
var_formula                   varchar(50);
livalnominal                  numeric;
livalteonom                   numeric;
--ecm 26 septiembre 2016 captura - estructura capital social -
--agregar valor de porcentaje cuando sea valor teorico nominal.
liidnominal numeric;
liidteoriconominal numeric;
liidnominal2      numeric;
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
select  val_valor
into strict    liidteoriconominal
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 1076
and     id_empresa = param_id_empresa
;
exception
when no_data_found then
liidteoriconominal := 0;
end;
execute 'ALTER SESSION SET NULLIF(NLS_NUMERIC_CHARACTERS::text, '') IS NULL.,;' ; /* dmap converted statement */
--checkbox
select
count(*) into strict  var_aplicacapitalfijo
from
dercorp_add_campo_valor_tab
where
id_empresa = param_id_empresa
and
id_add_campo = 1030
;
--checkbox
select
count(*) into strict  var_aplicacapitalvariable
from
dercorp_add_campo_valor_tab
where
id_empresa = param_id_empresa
and
id_add_campo = 1031
;
--
-- nava - issue: 9 3nov
--
update dercorp_metatbl_tab set
val_c3 = replace(val_c3, ',',''),
val_c4 = replace(val_c4, ',','')
where
id_empresa = param_id_empresa
and
id_flex_tbl = 7;
var_formula := xxtv_capital_soc_pkg_formula_total_fn(param_id_empresa);
if var_formula = 'ACF_ACV_VN' then
--ecm 26 septiembre 2016
if liidnominal > 0 then
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
and     id_add_campo = 1076
;*/
--08-03-2018 jjaq y jams se pone porque salia error cuando seleccionaba en valor nominal la opcion sin valor nominal
begin
select  (replace(replace(val_cat_val, '$', ''), ',', ''))::numeric  into strict liidnominal2
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = 11111;
exception
when others then
liidnominal2 := -1;
livalnominal := 1;
end;
if liidnominal2 <> -1
then
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
and     id_add_campo = 519
;
end if;
else
livalnominal:=1;
/*--ecm 27 octubre 2015
select
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
and id_meta_row = piinidmetarow
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
and    id_meta_row = piinidmetarow
;
end if;
select
sum((val_c6)::numeric ) into strict var_tab7_totalvaloracciones
from
dercorp_metatbl_tab
where
id_empresa = param_id_empresa
and
id_flex_tbl = 7;
-- %
if var_tab7_totalvaloracciones <> 0 then
update dercorp_metatbl_tab set
val_c5 =
round(((val_c6)::numeric  / var_tab7_totalvaloracciones * 100),7)
where
id_empresa = param_id_empresa
and
id_flex_tbl = 7;
else
update dercorp_metatbl_tab set
val_c5 = '0'
where
id_empresa = param_id_empresa
and
id_flex_tbl = 7;
end if;end;
$body$
language plpgsql
;
