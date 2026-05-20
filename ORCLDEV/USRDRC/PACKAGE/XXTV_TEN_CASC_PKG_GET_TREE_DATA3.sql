create or replace procedure usrdrc.xxtv_ten_casc_pkg_get_tree_data3 (resultset inout refcursor, paramempresa varchar, paramfecha varchar, paramconsolida varchar, paramsegmento varchar, paramclasificacion varchar, parampais varchar, parannumoracle varchar, paramgiro varchar, paramporcentaje varchar, paramporcentajeopt varchar, paramporcentajecual varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_stringbuilder text;
--v_lastlevel number;
v_cadena          varchar(5000);
postarrtencasc refcursor;
pistouttype    varchar(20):='DBMS';
--listempresaname    varchar(200);
xx_row record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from app_temp_log;
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
dercorp_reporte_tencasc_g_tmp ext;/* dmap converted statement start */
/**/
--v_lastlevel := 0;
v_stringbuilder :=  concat('var data = [', chr(10)) ;/* dmap converted statement end */
for xx_row in (
select
'{ id: '
--||  ext.des_dato1 ||
|| ext.id_row || --- ||
', parent:  ' ||
--nvl(ext.des_dato4,null) ||  - ||
--(select inter.id_row from dercorp_reporte_tencasc_id_tmp inter where inter.des_dato1 = nvl(ext.des_dato4,null)) ||
(case coalesce(ext.des_dato4,'null')
when 'null' then 'null'
else
--ok
(select
'' || max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
where
inter.des_dato1 = coalesce(ext.des_dato4,'null')
and
inter.id_row < ext.id_row
)
--(select inter.id_row ||  from dercorp_reporte_tencasc_id_tmp inter where inter.des_dato1 = nvl(ext.des_dato4,null))
end
) ||
--nvl((select inter.id_row from dercorp_reporte_tencasc_id_tmp inter where inter.des_dato1 = nvl(ext.des_dato4,null)),null) ||
/*nvl(
(select
|| max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
where
inter.des_dato1 = nvl(ext.des_dato4,null)
and
inter.id_row < ext.id_row
)
,null)
||*/
', empresa : "' || ext.des_dato3 || --lpad(-::text, rownum, -::text) ||
'", directo: "' || ext.des_dato5 ||
'", indirecto: "' || ext.des_dato6 ||
'" },' as row_data
from
dercorp_reporte_tencasc_id_tmp ext
where
nullif(ext.des_dato4::text, '') is null
union
select
'{ id: '
--||  ext.des_dato1 ||
|| ext.id_row || --- ||
', parent:  ' ||
--nvl(ext.des_dato4,null) ||  - ||
--(select inter.id_row from dercorp_reporte_tencasc_id_tmp inter where inter.des_dato1 = nvl(ext.des_dato4,null)) ||
(case coalesce(ext.des_dato4,'null')
when 'null' then 'null'
else
--ok
(select
'' || max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
where
inter.des_dato1 = coalesce(ext.des_dato4,'null')
and
inter.id_row < ext.id_row
)
--(select inter.id_row ||  from dercorp_reporte_tencasc_id_tmp inter where inter.des_dato1 = nvl(ext.des_dato4,null))
end
) ||
--nvl((select inter.id_row from dercorp_reporte_tencasc_id_tmp inter where inter.des_dato1 = nvl(ext.des_dato4,null)),null) ||
/*nvl(
(select
|| max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
where
inter.des_dato1 = nvl(ext.des_dato4,null)
and
inter.id_row < ext.id_row
)
,null)
||*/
', empresa : "' || ext.des_dato3 || --lpad(-::text, rownum, -::text) ||
'", directo: "' || ext.des_dato5 ||
'", indirecto: "' || ext.des_dato6 ||
'" },' as row_data
from
dercorp_reporte_tencasc_id_tmp ext
where (
coalesce(trim(both app_common_pkg_get_field_value(516,ext.des_dato1)),'NULL') like '%' || paramconsolida || '%'
/*or
(
app_common_pkg_get_field_value(516,ext.des_dato1) is null
and
length(paramconsolida) = 0
)*/
)
and (
coalesce(trim(both app_common_pkg_get_field_value(506,ext.des_dato1)),'NULL') like '%' || paramsegmento || '%'
--or app_common_pkg_get_field_value(506,ext.des_dato1) is null
)
and (
coalesce(trim(both app_common_pkg_get_field_value(507,ext.des_dato1)),'NULL') like '%' || paramclasificacion || '%'
--or app_common_pkg_get_field_value(507,ext.des_dato1) is null
)
and (
coalesce(trim(both app_common_pkg_get_field_value(509,ext.des_dato1)),'NULL') like '%' || parampais || '%'
--or app_common_pkg_get_field_value(509,ext.des_dato1) is null
)
and (
coalesce(trim(both app_common_pkg_get_field_value(502,ext.des_dato1)),'NULL') like '%' || parannumoracle || '%'
/*or
(
app_common_pkg_get_field_value(502,ext.des_dato1) is null
and
length(paramconsolida) = 0
)*/
)
and (
coalesce(trim(both app_common_pkg_get_field_value(504,ext.des_dato1)),'NULL') like '%' || paramgiro || '%'
--or app_common_pkg_get_field_value(504,ext.des_dato1) is null
)
/*
and
(
ext.des_dato1 = paramempresa
or
length(paramporcentaje) = 0
or
ext.des_dato5 like % || nvl(paramporcentaje,) || %
or
ext.des_dato6 like % || nvl(paramporcentaje,) || %
--or app_common_pkg_get_field_value(504,ext.des_dato1) is null
)*/
and
(
(
nullif(ext.des_dato5::text, '') is null
or
nullif(ext.des_dato6::text, '') is null
)
or
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
)
and app_common_pkg_get_field_text_value(507,ext.des_dato1)  <> 'Fusionada'
-- and ext.des_dato4 is not null --jams 27-03-2018
--where
--  tab.des_dato3 like %s.a.%
)
loop
v_stringbuilder := v_stringbuilder || xx_row.row_data || chr(10); -- || <br>;    ---- line jump
end loop;
v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, '];' , chr(10)) ;/* dmap converted statement end */
call xxtv_ten_casc_pkg_dump_clob(v_stringbuilder,3);
/* commit; */
--jjaq 29/03/2017
call xxtv_ten_casc_pkg_quitar_padre_hijos_pr();
open resultset for
select
app_common_pkg_get_txt_html_fn(text) as text
from
app_temp_log
where
nullif(text::text, '') is not null
and
text <> 'null'
order by
log_id;end;
$body$
language plpgsql
;
