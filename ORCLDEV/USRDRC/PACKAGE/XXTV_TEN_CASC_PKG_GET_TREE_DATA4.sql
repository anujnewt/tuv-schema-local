create or replace procedure usrdrc.xxtv_ten_casc_pkg_get_tree_data4 (resultset inout refcursor, paramempresa varchar, paramfecha varchar, paramconsolida varchar, paramsegmento varchar, paramclasificacion varchar, parampais varchar, parannumoracle varchar, paramgiro varchar, paramporcentaje varchar, paramporcentajeopt varchar, paramporcentajecual varchar, paramporcentajevisualizar varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_stringbuilder text;
--v_lastlevel number;
postarrtencasc refcursor;
pistouttype    varchar(20):='DBMS';
--listempresaname    varchar(200);
countcolors integer;
xx_rama record;
xx_row record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from app_temp_log;
delete from dercorp_reporte_tencasc_tmp;
delete from dercorp_repor_tencasc_id_tmp_2;
delete from dercorp_reporte_tencasc_g_tmp;
call dercorp_report_tencasc_pkg_do_report_pr(postarrtencasc, pistouttype, paramempresa);
--delete from dercorp_reporte_tencasc_id_tmp;
--delete dercorp_repor_tencasc_id_tmp_2;
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
) select * into strict --dercorp_reporte_tencasc_id_tmp
dercorp_repor_tencasc_id_tmp_2
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
ext.des_dato10,
'',
'#29A01C' from cte where nullif(ext.des_dato4::text, '') is null
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
ext.des_dato10,
'',
'#29A01C'
from
--dercorp_reporte_tencasc_tmp ext
dercorp_reporte_tencasc_g_tmp ext;
/**/
--
-- scripts finales
--
-- hijos de raiz
update dercorp_repor_tencasc_id_tmp_2 set
rama = row_number() over () as where
des_dato4 = 248;
for xx_rama in (select distinct rama from dercorp_repor_tencasc_id_tmp_2 where nullif(rama::text, '') is not null)
loop
for i in 1..10 loop
update dercorp_repor_tencasc_id_tmp_2 set
rama = xx_rama.rama
where
des_dato4 in (select
des_dato1
from
dercorp_repor_tencasc_id_tmp_2
where
rama = xx_rama.rama)
;
end loop;
end loop;
/*
select count(*) into countcolors
from
dercorp_repor_tencasc_colors
;
*/
update dercorp_repor_tencasc_id_tmp_2 set
color = (select color from dercorp_repor_tencasc_colors
where
--mod(countcolors,rama) =  id
id = rama
)
;/* dmap converted statement start */
--v_lastlevel := 0;
v_stringbuilder :=  concat('data.addRows([', chr(10)) ;/* dmap converted statement end */
for xx_row in (
select
'[{v:' || chr(39) ||  ext.id_row || chr(39) ||
', f:' || chr(39) ||  ext.des_dato3 || '<div style="background-color:'||ext.color||'">'||
--<div style=color:red; font-style:italic>directo: ||ext.des_dato5||</div>||
(case
when upper(paramporcentajevisualizar) in ('DIRECTO','AMBOS')
then
'<div style="color:red; font-style:italic">directo: "'||ext.des_dato5||'"</div>'
else
'' end
) ||
--<div style=color:blue; font-style:italic>indirecto: ||ext.des_dato6||</div>||chr(39)||}||
(case
when upper(paramporcentajevisualizar) in ('INDIRECTO','AMBOS')
then
'<div style="color:blue; font-style:italic">indirecto: "'||ext.des_dato6||'"</div>'
else
'' end
) || '</div>' ||
chr(39)|| '}' ||
','||chr(39)||
(case coalesce(ext.des_dato4,'')
when '' then ''
else
--ok
(select
'' || max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
where
inter.des_dato1 = coalesce(ext.des_dato4,'')
and
inter.id_row < ext.id_row
)
end
) ||chr(39) ||
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
','||chr(39)||chr(39)||'],' as row_data
from
dercorp_repor_tencasc_id_tmp_2 ext
where
nullif(ext.des_dato4::text, '') is null
union
select
'[{v:' || chr(39) ||  ext.id_row || chr(39) ||
', f:' || chr(39) ||  ext.des_dato3 || '<div style="background-color:'||ext.color||'">'||
--<div style=color:red; font-style:italic>directo: ||ext.des_dato5||</div>||
(case
when upper(paramporcentajevisualizar) in ('DIRECTO','AMBOS')
then
'<div style="color:red; font-style:italic">directo: "'||ext.des_dato5||'"</div>'
else
'' end
) ||
--<div style=color:blue; font-style:italic>indirecto: ||ext.des_dato6||</div>||chr(39)||}||
(case
when upper(paramporcentajevisualizar) in ('INDIRECTO','AMBOS')
then
'<div style="color:blue; font-style:italic">indirecto: "'||ext.des_dato6||'"</div>'
else
'' end
) || '</div>' ||
chr(39)|| '}' ||
','||chr(39)||
(case coalesce(ext.des_dato4,'')
when '' then ''
else
--ok
(select
'' || max(inter.id_row)
from
dercorp_reporte_tencasc_id_tmp inter
where
inter.des_dato1 = coalesce(ext.des_dato4,'')
and
inter.id_row < ext.id_row
)
end
) ||chr(39) ||
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
','||chr(39)||chr(39)||'],' as row_data
from
dercorp_repor_tencasc_id_tmp_2 ext
where
app_common_pkg_get_field_text_value(507,ext.des_dato1)  <> 'Fusionada'
and (app_common_pkg_get_field_value(516,ext.des_dato1)  = coalesce(paramconsolida, app_common_pkg_get_field_value(516,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(516,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(506,ext.des_dato1)  = coalesce(paramsegmento, app_common_pkg_get_field_value(506,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(506,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(507,ext.des_dato1)  = coalesce(paramclasificacion, app_common_pkg_get_field_value(507,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(507,ext.des_dato1)::text, '') is null )
and (app_common_pkg_get_field_value(509,ext.des_dato1)  = coalesce(parampais, app_common_pkg_get_field_value(509,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(509,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(502,ext.des_dato1)  = coalesce(parannumoracle, app_common_pkg_get_field_value(502,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(502,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(504,ext.des_dato1)  = coalesce(paramgiro, app_common_pkg_get_field_value(504,ext.des_dato1)) or nullif(app_common_pkg_get_field_value(504,ext.des_dato1)::text, '') is null)
--   and (app_common_pkg_get_field_value(505,ext.des_dato1)  = nvl(paramdivision, app_common_pkg_get_field_value(505,ext.des_dato1)) or app_common_pkg_get_field_value(505,ext.des_dato1) is null)--division jams 26/07/2017
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
--where
--  tab.des_dato3 like %s.a.%
)
loop
v_stringbuilder := v_stringbuilder || xx_row.row_data || chr(10);-- || <br>;    ---- line jump
end loop;
v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, ']);' , chr(10)) ;/* dmap converted statement end */
call xxtv_ten_casc_pkg_dump_clob(v_stringbuilder,4);
/* commit; */
--ecm 12 agosto 2016 - quitar numeros de los nodos padre que no cumplen con el filtro.
--xxtv_ten_casc_pkg_new_tenc_casc_pr; jjaq se comenta para que no borre el idparent
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
