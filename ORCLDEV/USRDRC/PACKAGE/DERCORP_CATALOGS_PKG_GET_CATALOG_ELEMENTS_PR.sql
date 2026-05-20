create or replace procedure usrdrc.dercorp_catalogs_pkg_get_catalog_elements_pr (catalogid integer, lstfilter varchar, lstcurrentids varchar,piinrolid numeric, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstquery varchar(4000):= null;
lstin    varchar(2000):= null;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select atributo1 into strict lstin
from   ss_rol_tab
where  id_rol = piinrolid;
if nullif(lstin::text, '') is null then
lstin := '0';
end if;
exception
when others then
lstin := '0';
end;/* dmap converted statement start */
if catalogid = 0 then
open resultset for
select   id_empresa,
nom_empresa
from     dercorp_empresa_tab
where (
app_common_pkg_sin_acentos_fn(upper(nom_empresa)) like app_common_pkg_sin_acentos_fn(upper( concat('%', replace(lstfilter,' ','%'), '%'))
) or
lstcurrentids like  concat('%', id_empresa , '%'
)
)  order by   nom_empresa;/* dmap converted statement end *//* dmap converted statement start */
elsif catalogid = 1 then
if piinrolid = 0 then
--ecm 04 mayo 2016
/*
lstquery := 'select distinct(cat.id_catalogo_valor), cat.val_cat_val from dercorp_add_campo_cat_val_tab cat, dercorp_busqueda_view vemp where 1=1 and cat.val_cat_val = vemp.denom_actual and cat.id_catalogo = 1 and (cat.val_cat_val like ''% replace(' || lstfilter || ', '''', ''%'') %'' or ' || lstcurrentids || ' like ''% cat.id_catalogo_valor %'')  order by  val_cat_val'; /* dmap converted statement */
*/
--ecm 25 mayo 2016
lstquery :=  concat('select distinct(cat.id_catalogo_valor), cat.val_cat_val from dercorp_add_campo_cat_val_tab cat, dercorp_busqueda_view vemp where 1=1 and cat.val_cat_val = vemp.denom_actual and cat.id_catalogo = 1 and (cat.val_cat_val like ''% replace(', lstfilter , ', '''', ''%'') %'' or ' , lstcurrentids , ' like ''% cat.id_catalogo_valor %'') and vemp.id_empresa not in (' , lstin , ')  ORDER BY  VAL_CAT_VAL') ; /* dmap converted statement end *//* dmap converted statement start *//* dmap converted statement */
else
/*
lstquery := select distinct(cat.id_catalogo_valor),
cat.val_cat_val
from   dercorp_add_campo_cat_val_tab cat,
dercorp_busqueda_view vemp
where  1=1
and    cat.val_cat_val = vemp.denom_actual
and    cat.id_catalogo = 1
and    ( app_common_pkg_sin_acentos_fn(upper(cat.val_cat_val)) like app_common_pkg_sin_acentos_fn(upper(% ||replace(lstfilter,  , %)||%))
or
||||lstcurrentids|||| like  %||cat.id_catalogo_valor||%)
and     vemp.id_empresa not in (||lstin||)
order by  val_cat_val;
*/
--ecm 25 mayo 2016
lstquery :=  concat('select distinct(cat.id_catalogo_valor),
cat.val_cat_val
from   dercorp_add_campo_cat_val_tab cat,
dercorp_busqueda_view vemp
where  1=1
and    cat.val_cat_val = vemp.denom_actual
and    cat.id_catalogo = 1
and    (cat.val_cat_val like ''%', replace(lstfilter, ' ', '%') , '%''
or '
, '''', lstcurrentids, '''', ' like  ''%''||cat.id_catalogo_valor||''%'')
and     vemp.id_empresa not in (', lstIn, ')
order by  val_cat_val') ;/* dmap converted statement end */
end if;
open resultset for execute lstquery;/* dmap converted statement start */
elsif catalogid = 1000 then
open resultset for
select   id_reporte,
nom_reporte
from     dercorp_reporte_tab
where (
app_common_pkg_sin_acentos_fn(upper(nom_reporte)) like app_common_pkg_sin_acentos_fn(upper( concat('%', replace(lstfilter,' ','%'), '%'))
) or
lstcurrentids like  concat('%', id_reporte , '%'
)
)  order by   nom_reporte;/* dmap converted statement end *//* dmap converted statement start */
elsif catalogid = 2000 then
open resultset for
select   id_reportflex,
nom_reporte
from     dercorp_reportflex_tab
where (
app_common_pkg_sin_acentos_fn(upper(nom_reporte)) like app_common_pkg_sin_acentos_fn(upper( concat('%', replace(lstfilter,' ','%'), '%'))
) or
lstcurrentids like  concat('%', id_reportflex , '%'
)
)  order by   nom_reporte;/* dmap converted statement end *//* dmap converted statement start */
elsif catalogid = 666 then
open resultset for
select  distinct(1)
,trim(both nombre) as  nombre
from    dercorp_rep_hist_func_vw
where   1=1
and     nullif(nombre::text, '') is not null
and     app_common_pkg_sin_acentos_fn(upper(nombre)) like app_common_pkg_sin_acentos_fn(upper( concat('%', replace(lstfilter,' ','%'), '%'))
)  order by  nombre
;/* dmap converted statement end *//* dmap converted statement start */
--ecm 27 enero 2016 agregar catalogo manual para la pesta?a contratos, campo nombres en captura.
elsif catalogid = 6969 then
open resultset for
select  pt.person_id
,pt.nombre
from    dercorp_cat_personas_total_tab pt
where   1=1
and     app_common_pkg_sin_acentos_fn(upper(pt.nombre)) like app_common_pkg_sin_acentos_fn(upper( concat('%', replace(lstfilter,' ','%'), '%'))
)  order by  pt.nombre
;/* dmap converted statement end *//* dmap converted statement start */
elsif catalogid = 6969 then
open resultset for
select  pt.person_id
,pt.nombre
from    dercorp_cat_personas_total_tab pt
where   1=1
and     app_common_pkg_sin_acentos_fn(upper(pt.nombre)) like app_common_pkg_sin_acentos_fn(upper( concat('%', replace(lstfilter,' ','%'), '%'))
)  order by  pt.nombre
;/* dmap converted statement end *//* dmap converted statement start */
--- nava
--- enero 2016
--- catalogo de semaforo para que se muestre el nombre del color en espaniol
elsif catalogid = 31 then
open resultset for
select
id_catalogo_valor,
--cod_cat_val,
--val_cat_val
nom_cat_val
from
dercorp_add_campo_cat_val_tab
where
id_catalogo = catalogid
and (
app_common_pkg_sin_acentos_fn(upper(val_cat_val)) like app_common_pkg_sin_acentos_fn(upper( concat('%', replace(lstfilter, ' ', '%') , '%'))
) or
lstcurrentids like  concat('%', id_catalogo_valor , '%'
)
)  order by
--val_cat_val
nom_cat_val
;/* dmap converted statement end *//* dmap converted statement start */
else
open resultset for
select
id_catalogo_valor,
--cod_cat_val,
val_cat_val
from
dercorp_add_campo_cat_val_tab
where
id_catalogo = catalogid
and (
app_common_pkg_sin_acentos_fn(upper(val_cat_val)) like app_common_pkg_sin_acentos_fn(upper( concat('%', replace(lstfilter, ' ', '%') , '%'))
) or
lstcurrentids like  concat('%', id_catalogo_valor , '%'
)
)  order by
app_common_pkg_sin_acentos_fn(val_cat_val)
;/* dmap converted statement end */
end if;end;
$body$
language plpgsql
;
