create or replace procedure usrdrc.dercorp_reportflex_pkg_get_campos_pr (resultset inout refcursor, sectionid numeric, subsectionid numeric, paramfilter varchar, showflextabs varchar, showflexcolumns varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select * from (
select
campo.id_add_campo,
--to_char(campo.id_add_campo),
concat((
case campo.id_add_campo
when 520 then campo.atributo6
when 1077 then campo.atributo6
when 564 then campo.atributo6
when 1051 then campo.atributo6
else
campo.nom_campo end
), (
) case campo.des_tipo_campo when 'FLEXTABLE' then ' (TABLA)'
else '' end
) as nom_campo,
campo.des_tipo_campo,
campo.id_flex_tbl,
campo.id_catalogo,
secc.nom_seccion,
subsecc.nom_subseccion,
secc.id_seccion,
subsecc.id_subseccion,
0 as id_orden,
'' as cod_flex_colum
from
dercorp_add_campo_tab campo
inner join dercorp_add_campo_seccion_tab secc on secc.id_seccion = campo.id_seccion
inner join dercorp_add_campo_sub_sec_tab subsecc on subsecc.id_subseccion = campo.id_subseccion
where (
length(trim(both campo.nom_campo)) > 0
or
id_add_campo in (520,1077)
)
and
secc.id_seccion = (case sectionid when 0 then secc.id_seccion else sectionid end)
and
subsecc.id_subseccion = (case subsectionid when 0 then subsecc.id_subseccion else subsectionid end)
and (
app_common_pkg_sin_acentos_fn(upper(case campo.id_add_campo
when 520 then campo.atributo6
when 1077 then campo.atributo6
else
campo.nom_campo end)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
) or
app_common_pkg_sin_acentos_fn(upper(subsecc.nom_subseccion)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
) or
app_common_pkg_sin_acentos_fn(upper(secc.nom_seccion)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
)
) and
campo.des_tipo_campo not in ('LABEL','AJAX_PAGE')
and (campo.des_tipo_campo not in ('FLEXTABLE') or showflextabs = 'SI')
and nullif(subsecc.atributo1::text, '') is null
and
coalesce(campo.des_formula,'NULL') not like '%showMe%'
and nullif(campo.atributo7::text, '') is null
and campo.id_add_campo not in (1058,2002)--se omite reforma total
and campo.id_add_campo not in (1070)--jams 20/02/2018 se omite contratos de reformas y movimientos
and campo.id_add_campo not in (1057)--jams 09/03/2018 se omite aumento de capital s.a. (tabla)
and secc.id_seccion not in (22,23,24)--jjaq 05/09/2017 se omite todo lo que tenga que ver cn poderes
union all
select
campo.id_add_campo,
--to_char(campo.id_add_campo),
--campo.nom_campo
concat((
case campo.id_add_campo
when 520 then campo.atributo6
when 1077 then campo.atributo6
when 564 then campo.atributo6
when 1051 then campo.atributo6
else
campo.nom_campo end
), (
) case campo.des_tipo_campo when 'FLEXTABLE' then ' (TABLA)'
else '' end
) as nom_campo,
campo.des_tipo_campo,
campo.id_flex_tbl,
campo.id_catalogo,
secc.nom_seccion,
subsecc.nom_subseccion,
secc.id_seccion,
subsecc.id_subseccion,
0 as id_orden,
'' as cod_flex_colum
from
dercorp_add_campo_tab campo
inner join dercorp_add_campo_seccion_tab secc on secc.id_seccion = case when campo.id_seccion=250 then 25                                                                                                         when campo.id_seccion=31 then 25 end
inner join dercorp_add_campo_sub_sec_tab subsecc on subsecc.id_subseccion = case when campo.id_subseccion=470 then 47                                                                                                                     when campo.id_subseccion=60 then 47 end
where (
length(trim(both campo.nom_campo)) > 0
or
id_add_campo in (520,1077)
)
and
secc.id_seccion = (case sectionid when 0 then secc.id_seccion else sectionid end)
and
subsecc.id_subseccion = (case subsectionid when 0 then subsecc.id_subseccion else subsectionid end)
and (
app_common_pkg_sin_acentos_fn(upper(campo.nom_campo)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
) or
app_common_pkg_sin_acentos_fn(upper(subsecc.nom_subseccion)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
) or
app_common_pkg_sin_acentos_fn(upper(secc.nom_seccion)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
)
) and
campo.des_tipo_campo not in ('LABEL','AJAX_PAGE')
and (campo.des_tipo_campo not in ('FLEXTABLE') or showflextabs = 'SI')
and
coalesce(campo.des_formula,'NULL') not like '%showMe%'
and
nullif(campo.atributo7::text, '') is null
and campo.id_add_campo not in (1058,2002)--se omite reforma total
and campo.id_add_campo not in (1070)--jams 20/02/2018 se omite contratos de reformas y movimientos
and campo.id_add_campo not in (1057)--jams 09/03/2018 se omite aumento de capital s.a. (tabla)
and secc.id_seccion not in (22,23,24)--jjaq 05/09/2017 se omite todo lo que tenga que ver cn poderes
union all
select
flexcol.id_flex_colum * 10000,
--flexcol.cod_flex_colum,
--flexcol.des_flex_colum nom_campo,
flexcol.nom_flex_colum nom_campo,
flexcol.des_tipo_colum,
flexcol.id_flex_tbl,
flexcol.id_catalogo,
secc.nom_seccion,
flextab.nom_flex nom_subseccion,
--subsecc.nom_subseccion,
secc.id_seccion,
subsecc.id_subseccion,
flexcol.id_orden,
flexcol.cod_flex_colum
from
dercorp_flex_colums_tab                 flexcol
inner join dercorp_flex_tbls_tab        flextab on  flextab.id_flex_tbl = flexcol.id_flex_tbl
and
nullif(flextab.attribute_category::text, '') is null
and flextab.id_flex_tbl not in (20)
left join dercorp_add_campo_tab         campo   on  campo.id_flex_tbl = flexcol.id_flex_tbl
left join dercorp_add_campo_seccion_tab secc    on  secc.id_seccion = case when campo.id_seccion=250 then 25 when campo.id_seccion=31 then 25  else campo.id_seccion end
and
secc.id_seccion = (case sectionid when 0 then secc.id_seccion else sectionid end)
left join dercorp_add_campo_sub_sec_tab subsecc on  subsecc.id_subseccion = case when campo.id_subseccion=470 then 47 when campo.id_subseccion=60 then 47  else campo.id_subseccion end
and
subsecc.id_subseccion =(case subsectionid when 0 then subsecc.id_subseccion else subsectionid end) alias60
where
--length(trim(flexcol.des_flex_colum)) > 0
length(trim(both flexcol.nom_flex_colum)) > 0
and (
app_common_pkg_sin_acentos_fn(upper(flexcol.nom_flex_colum)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
) or
app_common_pkg_sin_acentos_fn(upper(flextab.nom_flex)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
) or
app_common_pkg_sin_acentos_fn(upper(secc.nom_seccion)) like  concat('%', app_common_pkg_sin_acentos_fn(upper(paramfilter)) , '%'
)
) and
--length(trim(flexcol.des_flex_colum)) > 0
length(trim(both flexcol.nom_flex_colum)) > 0
and
showflexcolumns = 'SI'
and flexcol.id_flex_colum not in (303)--se omite reforma total
and
nullif(campo.atributo7::text, '') is null
and secc.id_seccion not in (22,23,24)--jjaq 05/09/2017 se omite todo lo que tenga que ver cn poderes
and campo.id_add_campo not in (1070)--jams 20/02/2018 se omite contratos de reformas y movimientos
group by
flexcol.id_flex_colum * 10000,
flexcol.nom_flex_colum ,
flexcol.des_tipo_colum,
flexcol.id_flex_tbl,
flexcol.id_catalogo,
secc.nom_seccion,
flextab.nom_flex ,
secc.id_seccion,
subsecc.id_subseccion,
flexcol.id_orden,
flexcol.cod_flex_colum) a
order by
/*
id_seccion,
id_subseccion,
nom_subseccion,
nom_campo
*/
id_seccion,
a.id_flex_tbl,
a.id_orden,
(replace(a.cod_flex_colum, 'VAL_C', ''))::numeric
;/* dmap converted statement end */end;
$body$
language plpgsql
;
