create or replace procedure usrdrc.xxtv_ten_casc_pkg_get_tree_data1 (resultset inout refcursor, paramempresa varchar, paramfecha varchar, paramconsolida varchar, paramsegmento varchar, paramclasificacion varchar, parampais varchar, parannumoracle varchar, paramgiro varchar, paramporcentaje varchar, paramporcentajeopt varchar, paramporcentajecual varchar, paramporcentajevisualizar varchar, paramdivision varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
postarrtencasc refcursor;
pistouttype       varchar(20):='DBMS';
pistcout          numeric;
pistcout2         numeric;
pistcountidparent numeric;
rownumberupdate   numeric := 1;
v_cadena          varchar(5000);
rr refcursor;
query_id_parent_cur cursor for
select distinct id_parent from pendium_ten_casc_paso_tmp where id_parent <> 1 order by id_parent;
ten_casc_cur cursor for
select
row_number() over () as super_query_rownum,
ext.id_row,
(case coalesce(ext.des_dato4,'null')
when 'null' then 'null'
else (select
'' || max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
where
inter.des_dato1 = coalesce(ext.des_dato4,'null')
and
inter.id_row < ext.id_row
)
end
) id_parent,
ext.des_dato1,
ext.des_dato2,
-- lpad(ext.des_dato3::text, length(ext.des_dato3) + level * 5 - 5) as nom_empresa,
--lpad(::text, 5 + level * 5 - 5) as pad,
ext.des_dato3,
ext.des_dato4,
ext.des_dato5 directo,
ext.des_dato6 indirecto,
ext.des_dato7,
--level ten_casc_level,
(select
count(*)
from
dercorp_reporte_tencasc_id_tmp
where
des_dato4 = ext.des_dato1) cant_hijos,
app_common_pkg_get_field_text_value(516,ext.des_dato1) as consolida,
app_common_pkg_get_field_text_value(506,ext.des_dato1) as segmento,
app_common_pkg_get_field_text_value(507,ext.des_dato1) as clasificacion,
app_common_pkg_get_field_text_value(509,ext.des_dato1) as pais,
app_common_pkg_get_field_text_value(502,ext.des_dato1) as no_emp_oracle,
app_common_pkg_get_field_text_value(504,ext.des_dato1) as giro,
app_common_pkg_get_field_text_value(505,ext.des_dato1) as division,--division jams 26/07/2017
'' as consolida_all,
'' as segmento_all,
'' as clasificacion_all,
'' as pais_all,
'' as no_emp_oracle_all,
'' as giro_all,
'' as division_all
from
dercorp_reporte_tencasc_id_tmp ext
where
app_common_pkg_get_field_text_value(507,ext.des_dato1)  <> 'Fusionada'
and (app_common_pkg_get_field_value(516,ext.des_dato1)  = coalesce(paramconsolida, app_common_pkg_get_field_value(516,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(516,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(506,ext.des_dato1)  = coalesce(paramsegmento, app_common_pkg_get_field_value(506,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(506,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(507,ext.des_dato1)  = coalesce(paramclasificacion, app_common_pkg_get_field_value(507,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(507,ext.des_dato1)::text, '') is null )
and (app_common_pkg_get_field_value(509,ext.des_dato1)  = coalesce(parampais, app_common_pkg_get_field_value(509,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(509,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(502,ext.des_dato1)  = coalesce(parannumoracle, app_common_pkg_get_field_value(502,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(502,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(504,ext.des_dato1)  = coalesce(paramgiro, app_common_pkg_get_field_value(504,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(504,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(505,ext.des_dato1)  = coalesce(paramdivision, app_common_pkg_get_field_value(505,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(505,ext.des_dato1)::text, '') is null)--division jams 26/07/2017
and
(
(
paramporcentajecual = 'Directo'
and
(
(paramporcentajeopt = '1' and (ext.des_dato5)::numeric  = (paramporcentaje)::numeric )
or (paramporcentajeopt = '2' and (ext.des_dato5)::numeric  > (paramporcentaje)::numeric )
or (paramporcentajeopt = '3' and (ext.des_dato5)::numeric  < (paramporcentaje)::numeric )
)
)
or
(
paramporcentajecual = 'Indirecto'
and
(
(paramporcentajeopt = '1' and (ext.des_dato6)::numeric  = (paramporcentaje)::numeric )
or (paramporcentajeopt = '2' and (ext.des_dato6)::numeric  > (paramporcentaje)::numeric )
or (paramporcentajeopt = '3' and (ext.des_dato6)::numeric  < (paramporcentaje)::numeric )
)
)
)
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
v_cadena:= '
select
rownum as super_query_rownum,
ext.id_row,
(case nvl(ext.des_dato4,''null'')
when ''null'' then ''null''
else
(select
'' || max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
--dercorp_reporte_tc_id_tmp inter
where
inter.des_dato1 = nvl(ext.des_dato4,''null'')
and
inter.id_row < ext.id_row
)
end
) id_parent,
ext.des_dato1,
ext.des_dato2,
ext.des_dato3,
ext.des_dato4,
ext.des_dato5 directo,
ext.des_dato6 indirecto,
ext.des_dato7,
(select
count(*)
from
dercorp_reporte_tencasc_id_tmp
where
des_dato4 = ext.des_dato1) cant_hijos,
app_common_pkg_get_field_text_value(516,ext.des_dato1) as consolida,
app_common_pkg_get_field_text_value(506,ext.des_dato1) as segmento,
app_common_pkg_get_field_text_value(507,ext.des_dato1) as clasificacion,
app_common_pkg_get_field_text_value(509,ext.des_dato1) as pais,
app_common_pkg_get_field_text_value(502,ext.des_dato1) as no_emp_oracle,
app_common_pkg_get_field_text_value(504,ext.des_dato1) as giro,
app_common_pkg_get_field_text_value(505,ext.des_dato1) as division,--division jams 26/07/2017
'' as consolida_all,
'' as segmento_all,
'' as clasificacion_all,
'' as pais_all,
'' as no_emp_oracle_all,
'' as giro_all,
'' as division_all
from
dercorp_reporte_tencasc_id_tmp ext
where
nullif(app_common_pkg_get_field_text_value(507,ext.des_dato1)::text, '') is not nullfusionada''
';/* dmap converted statement start */
if nullif(paramconsolida::text, '') is not null
then
v_cadena:=  concat(v_cadena, ' AND APP_COMMON_PKG_GET_FIELD_VALUE(516,EXT.DES_DATO1)  = paramConsolida') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(paramsegmento::text, '') is not null
then
v_cadena:=  concat(v_cadena, ' AND APP_COMMON_PKG_GET_FIELD_VALUE(506,EXT.DES_DATO1)  = paramSegmento') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(paramclasificacion::text, '') is not null
then
v_cadena:=  concat(v_cadena, ' AND APP_COMMON_PKG_GET_FIELD_VALUE(507,EXT.DES_DATO1)  = paramClasificacion') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(parampais::text, '') is not null
then
v_cadena:=  concat(v_cadena, ' AND APP_COMMON_PKG_GET_FIELD_VALUE(509,EXT.DES_DATO1)  = paramPais') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(parannumoracle::text, '') is not null
then
v_cadena:=  concat(v_cadena, ' AND APP_COMMON_PKG_GET_FIELD_VALUE(502,EXT.DES_DATO1)  = paranNumOracle') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(paramgiro::text, '') is not null
then
v_cadena:=  concat(v_cadena, ' AND APP_COMMON_PKG_GET_FIELD_VALUE(504,EXT.DES_DATO1)  = paramGiro') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(paramdivision::text, '') is not null
then
v_cadena:=  concat(v_cadena, ' AND APP_COMMON_PKG_GET_FIELD_VALUE(505,EXT.DES_DATO1)  = paramDivision') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
v_cadena:=  concat(v_cadena, '
and
(
(
paramporcentajecual = ''directo''
and
(
(paramporcentajeopt = ''1'' and to_number(ext.des_dato5) = to_number(paramporcentaje))
or
(paramporcentajeopt = ''2'' and to_number(ext.des_dato5) > to_number(paramporcentaje))
or
(paramporcentajeopt = ''3'' and to_number(ext.des_dato5) < to_number(paramporcentaje))
)
)
or
(
paramporcentajecual = ''indirecto''
and
(
(paramporcentajeopt = ''1'' and to_number(ext.des_dato6) = to_number(paramporcentaje))
or
(paramporcentajeopt = ''2'' and to_number(ext.des_dato6) > to_number(paramporcentaje))
or
(paramporcentajeopt = ''3'' and to_number(ext.des_dato6) < to_number(paramporcentaje))
)
)
)
') ;/* dmap converted statement end */
delete from dercorp_reporte_tencasc_tmp;
call dercorp_report_tencasc_pkg_do_report_pr(postarrtencasc, pistouttype, paramempresa);
delete from dercorp_reporte_tencasc_id_tmp;
delete from dercorp_reporte_tencasc_g_tmp;
insert into
dercorp_reporte_tencasc_g_tmp
select
ext.des_dato1,
ext.des_dato2,
ext.des_dato3,
ext.des_dato4,
sum(ext.des_dato5),
sum(ext.des_dato6),
ext.des_dato7,
ext.des_dato8,
ext.des_dato9,
ext.des_dato10
from
dercorp_reporte_tencasc_tmp ext
group by
ext.des_dato1,
ext.des_dato2,
ext.des_dato3,
ext.des_dato4,
ext.des_dato7,
ext.des_dato8,
ext.des_dato9,
ext.des_dato10;with recursive cte as (
insert
from
dercorp_reporte_tencasc_g_tmp ext where ext.des_dato4 = paramempresa
union all
insert
from
dercorp_reporte_tencasc_g_tmp ext join cte c on (c.des_dato1 = ext.des_dato4)
) select * into strict dercorp_reporte_tencasc_id_tmp
select
1,
ext.des_dato1,
ext.des_dato2,
ext.des_dato3,
ext.des_dato4,
ext.des_dato5,
ext.des_dato6,
ext.des_dato7,
ext.des_dato8,
ext.des_dato9,
ext.des_dato10 from cte where nullif(ext.des_dato4::text, '') is null
union
select
--distinct
row_number() over () + 1,
ext.des_dato1,
ext.des_dato2,
ext.des_dato3,
ext.des_dato4,
ext.des_dato5,
ext.des_dato6,
ext.des_dato7,
ext.des_dato8,
ext.des_dato9,
ext.des_dato10
from
--dercorp_reporte_tencasc_tmp ext
dercorp_reporte_tencasc_g_tmp ext;
/*
select
--distinct
rownum + 1,
ext.des_dato1,
ext.des_dato2,
ext.des_dato3,
ext.des_dato4,
ext.des_dato5,
ext.des_dato6,
ext.des_dato7,
ext.des_dato8,
ext.des_dato9,
ext.des_dato10
from
--dercorp_reporte_tencasc_tmp ext
(select distinct * from dercorp_reporte_tencasc_g_tmp) ext
start with ext.des_dato4 = paramempresa
connect by prior ext.des_dato1 = ext.des_dato4;
*/
--delete from dercorp_reporte_tc_id_tmp;
/*
insert into
dercorp_reporte_tc_id_tmp
select
id_row,
(case nvl(ext.des_dato4,null)
when null then null
else
--ok
(select
|| max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
where
inter.des_dato1 = nvl(ext.des_dato4,null)
and
inter.id_row < ext.id_row
)
--(select inter.id_row ||  from dercorp_reporte_tencasc_id_tmp inter where inter.des_dato1 = nvl(ext.des_dato4,null))
end
) id_parent,
des_dato1,
des_dato2,
des_dato3,
des_dato4,
des_dato5,
des_dato6,
des_dato7,
des_dato8,
des_dato9,
des_dato10
from
dercorp_reporte_tencasc_id_tmp ext;
*/
/* commit; */
delete from usrdrc.pendium_ten_casc_paso_tmp;
for i in ten_casc_cur
--open rr for v_cadena;
loop
/* select count(*) into pistcout
from pendium_ten_casc_paso_tmp te
--where id_row = i.id_row and id_parent = i.id_parent;
where te.des_dato1=i.des_dato1 and te.ten_casc_level=i.ten_casc_level;
select count(*) into pistcout2
from pendium_ten_casc_paso_tmp te
where des_dato1 = i.des_dato1 and id_parent = i.id_parent;
*/
-- if pistcout = 0 and pistcout2=0
-- then
-- exit when rr%notfound;
insert
into usrdrc.pendium_ten_casc_paso_tmp(
super_query_rownum,
id_row,
id_parent,
des_dato1,
--nom_empresa,
des_dato3,
des_dato2,
--pad,
des_dato4,
directo,
indirecto,
des_dato7,
--ten_casc_level,
cant_hijos,
consolida,
segmento,
clasificacion,
pais,
no_emp_oracle,
giro,
division,
consolida_all,
segmento_all,
clasificacion_all,
pais_all,
no_emp_oracle_all,
giro_all,
division_all
)values (
i.super_query_rownum,
i.id_row,
i.id_parent,
i.des_dato1,
--i.nom_empresa,
i.des_dato3,
i.des_dato2,
--i.pad,
i.des_dato4,
i.directo,
i.indirecto,
i.des_dato7,
--i.ten_casc_level,
i.cant_hijos,
i.consolida,
i.segmento,
i.clasificacion,
i.pais,
i.no_emp_oracle,
i.giro,
i.division,
i.consolida_all,
i.segmento_all,
i.clasificacion_all,
i.pais_all,
i.no_emp_oracle_all,
i.giro_all,
i.division_all
);
--end if;
end loop;with recursive cte as (
-- close rr;
--jjaq 29/03/2017 cursor para eliminar padre e hijos si no cuple con el porcentaje
/*jams 27/07/2017 se comenta porque al parecer ya no es necesario
for i in query_id_parent_cur
loop
select count(*) into pistcountidparent
from pendium_ten_casc_paso_tmp
where id_row = i.id_parent;
if pistcountidparent = 0
then
delete from pendium_ten_casc_paso_tmp where id_parent = i.id_parent;
/* commit; */
end if;
end loop;
*/
open resultset for
--select * from pendium_ten_casc_paso_tab where id_parent in (select id_row from pendium_ten_casc_paso_tab) or ten_casc_level =1  order by  id_row;
-- select * from pendium_ten_casc_paso_tmp  order by  id_row;
--select * from pendium_ten_casc_paso_tmp order by super_query_rownum;
select super_query_rownum,id_row,id_parent,des_dato1,des_dato2,--nom_empresa,
lpad(ext.des_dato3::text, length(ext.des_dato3) + 1 * 5 - 5, ' '::text) as nom_empresa,--pad,
lpad(' '::text, 5 + 1 * 5 - 5, ' '::text) as pad,des_dato4,directo,indirecto,des_dato7,--ten_casc_level,
1 ten_casc_level,cant_hijos,consolida,segmento,clasificacion,pais,no_emp_oracle,giro,consolida_all,segmento_all,clasificacion_all,pais_all,no_emp_oracle_all,giro_all,division_all,division,array[ row_number() over (order by  ext.des_dato3) ] as hierarchy
from pendium_ten_casc_paso_tmp ext where ext.des_dato4 = paramempresa
union all
open resultset for
select super_query_rownum,id_row,id_parent,des_dato1,des_dato2,
lpad(ext.des_dato3::text, length(ext.des_dato3) + (c.level+1) * 5 - 5, ' '::text) as nom_empresa,
lpad(' '::text, 5 + (c.level+1) * 5 - 5, ' '::text) as pad,des_dato4,directo,indirecto,des_dato7,
(c.level+1) ten_casc_level,cant_hijos,consolida,segmento,clasificacion,pais,no_emp_oracle,giro,consolida_all,segmento_all,clasificacion_all,pais_all,no_emp_oracle_all,giro_all,division_all,division, array_append(c.hierarchy, row_number() over (order by  ext.des_dato3))  as hierarchy
from pendium_ten_casc_paso_tmp ext join cte c on (c.id_row = ext.ext.id_parent)
) select * from cte order by hierarchy;
--  select * from pendium_ten_casc_paso_tmp;
end;
$body$
language plpgsql
;
