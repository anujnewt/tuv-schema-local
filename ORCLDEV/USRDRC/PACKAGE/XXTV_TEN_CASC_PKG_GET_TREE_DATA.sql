create or replace procedure usrdrc.xxtv_ten_casc_pkg_get_tree_data (resultset inout refcursor, paramempresa varchar, paramfecha varchar, paramconsolida varchar, paramsegmento varchar, paramclasificacion varchar, parampais varchar, parannumoracle varchar, paramgiro varchar, paramporcentaje varchar, paramporcentajeopt varchar, paramporcentajecual varchar, paramporcentajevisualizar varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_stringbuilder text;
v_lastlevel numeric;
postarrtencasc refcursor;
pistouttype    varchar(20):='DBMS';
xx_row record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from app_temp_log;
--delete from dercorp_reporte_tencasc_fis;
delete from dercorp_reporte_tencasc_tmp;
call dercorp_report_tencasc_pkg_do_report_pr(postarrtencasc, pistouttype, paramempresa);
v_lastlevel := 0;
v_stringbuilder:= null;/* dmap converted statement start */
for xx_row in (with recursive cte as (
/*
select
*
from
dercorp_reporte_tencasc2_tmp
where
consolida_all like % || paramconsolida || %
and
segmento_all like % || paramsegmento || %
and
clasificacion_all like % || paramclasificacion || %
and
pais_all like % || parampais || %
and
no_emp_oracle_all like % || parannumoracle || %
and
giro_all like % || paramgiro || %
-- order by
--des_dato1
start with des_dato4 = paramempresa
connect by prior des_dato1 = des_dato4
*/
select ext.des_dato1,ext.des_dato2,lpad(ext.des_dato3::text, length(ext.des_dato3) + 1 * 5 - 5, ' '::text) as nom_empresa,lpad(' '::text, 5 + 1 * 5 - 5, ' '::text) as pad,ext.des_dato4,ext.des_dato5 directo,ext.des_dato6 indirecto,ext.des_dato7,1 ten_casc_level,(select
count(*)
from
dercorp_reporte_tencasc_tmp
where
des_dato4 = ext.des_dato1) cant_hijos,app_common_pkg_get_field_text_value(516,ext.des_dato1) as consolida,app_common_pkg_get_field_text_value(506,ext.des_dato1) as segmento,app_common_pkg_get_field_text_value(507,ext.des_dato1) as clasificacion,app_common_pkg_get_field_text_value(509,ext.des_dato1) as pais,app_common_pkg_get_field_text_value(502,ext.des_dato1) as no_emp_oracle,app_common_pkg_get_field_text_value(504,ext.des_dato1) as giro,'' as consolida_all,'' as segmento_all,'' as clasificacion_all,'' as pais_all,'' as no_emp_oracle_all,'' as giro_all
from
dercorp_reporte_tencasc_tmp ext where ext.des_dato4 = paramempresa
union all
select ext.des_dato1,ext.des_dato2,lpad(ext.des_dato3::text, length(ext.des_dato3) + (c.level+1) * 5 - 5, ' '::text) as nom_empresa,lpad(' '::text, 5 + (c.level+1) * 5 - 5, ' '::text) as pad,ext.des_dato4,ext.des_dato5 directo,ext.des_dato6 indirecto,ext.des_dato7,(c.level+1) ten_casc_level,(select
count(*)
from
dercorp_reporte_tencasc_tmp
where
des_dato4 = ext.des_dato1) cant_hijos,app_common_pkg_get_field_text_value(516,ext.des_dato1) as consolida,app_common_pkg_get_field_text_value(506,ext.des_dato1) as segmento,app_common_pkg_get_field_text_value(507,ext.des_dato1) as clasificacion,app_common_pkg_get_field_text_value(509,ext.des_dato1) as pais,app_common_pkg_get_field_text_value(502,ext.des_dato1) as no_emp_oracle,app_common_pkg_get_field_text_value(504,ext.des_dato1) as giro,'' as consolida_all,'' as segmento_all,'' as clasificacion_all,'' as pais_all,'' as no_emp_oracle_all,'' as giro_all
from
dercorp_reporte_tencasc_tmp ext join cte c on (c.des_dato1 = ext.ext.des_dato4)
) select * from cte where /*
(
app_common_pkg_get_field_value(516,ext.des_dato1) like % || paramconsolida || %
or
(
app_common_pkg_get_field_value(516,ext.des_dato1) is null
and
length(paramconsolida) = 0
)
)*/
(app_common_pkg_get_field_value(516,ext.des_dato1) like  concat('%', paramconsolida , '%'
) or nullif(app_common_pkg_get_field_value(516,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(506,ext.des_dato1) like  concat('%', paramsegmento , '%'
) or nullif(app_common_pkg_get_field_value(506,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(507,ext.des_dato1) like  concat('%', paramclasificacion , '%'
) or nullif(app_common_pkg_get_field_value(507,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(509,ext.des_dato1) like  concat('%', parampais , '%'
) or nullif(app_common_pkg_get_field_value(509,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(502,ext.des_dato1) like  concat('%', parannumoracle , '%'
) or nullif(app_common_pkg_get_field_value(502,ext.des_dato1)::text, '') is null)
and (app_common_pkg_get_field_value(504,ext.des_dato1) like  concat('%', paramgiro , '%'
) or nullif(app_common_pkg_get_field_value(504,ext.des_dato1)::text, '') is null)
--and
--( ext.des_dato5 like % || paramporcentaje || %
--or ext.des_dato6 like % || paramporcentaje || %)
and
(
(
app_common_pkg. concat(get_field_value(516,ext.des_dato1), app_common_pkg_get_field_value(506,ext.des_dato1) , app_common_pkg_get_field_value(507,ext.des_dato1) , app_common_pkg_get_field_value(509,ext.des_dato1) , app_common_pkg_get_field_value(502,ext.des_dato1) , app_common_pkg_get_field_value(504,ext.des_dato1)
)
) like
concat('%', paramconsolida , paramsegmento , paramclasificacion , parampais , parannumoracle , paramgiro , '%'
)
) and
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
/*   */
)
loop
--if v_lastlevel < xx_row.level then
--  dbms_output.put_line(data:[);
--end if;
-- cerrar el nivel anterior
if v_lastlevel > xx_row.ten_casc_level then
v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , ']},') ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end */
--dbms_output.put_line(xx_row.pad || ]},);
end if;/* dmap converted statement start */
if v_lastlevel > (xx_row.ten_casc_level + 1) then
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , ']},') ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end */
--dbms_output.put_line(xx_row.pad || ]},);
end if;
/*
if xx_row.level = 1 then
v_stringbuilder := v_stringbuilder || xx_row.pad || },;
v_stringbuilder := v_stringbuilder || chr(10);
--dbms_output.put_line(xx_row.pad || ]},);
end if;
*/
--dbms_output.put_line(
v_stringbuilder := v_stringbuilder ||
xx_row.pad || '{ "nombre":"' || xx_row.nom_empresa ||
(case
when upper(paramporcentajevisualizar) in ('DIRECTO','AMBOS')
then
'", "directo":"' || xx_row.directo
else
'' end
) ||
--, directo: || xx_row.directo ||
(case
when upper(paramporcentajevisualizar) in ('INDIRECTO','AMBOS')
then
'", "indirecto":"' || xx_row.indirecto
else
'' end
) ||
--, indirecto: || xx_row.indirecto ||
'", "consolida":"' || xx_row.consolida ||
'", "segmento":"' || xx_row.segmento ||
'", "clasificacion":"' || xx_row.clasificacion ||
'", "pais":"' || xx_row.pais ||
'", "no_emp_oracle":"' || xx_row.no_emp_oracle ||
'", "giro":"' || xx_row.giro || '"';/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
if xx_row.cant_hijos > 0 then
--dbms_output.put_line(xx_row.pad || , data:[);
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , ', "data":[') ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
else
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '},') ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end */
end if;
v_lastlevel := xx_row.ten_casc_level;
end loop;
v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end */
--dbms_output.put_line(a);
--dbms_output.put_line(v_stringbuilder);
--dbms_output.put_line(b);
--retstrdata := v_stringbuilder;
call xxtv_ten_casc_pkg_dump_clob(v_stringbuilder,0);
/* commit; */
open resultset for
select
text
from
app_temp_log
order by
log_id;end;
$body$
language plpgsql
;
