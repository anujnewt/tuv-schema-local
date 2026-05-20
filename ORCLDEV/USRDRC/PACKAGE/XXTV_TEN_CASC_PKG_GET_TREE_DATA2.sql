create or replace procedure usrdrc.xxtv_ten_casc_pkg_get_tree_data2 (resultset inout refcursor, paramempresa varchar, paramfecha varchar, paramconsolida varchar, paramsegmento varchar, paramclasificacion varchar, parampais varchar, parannumoracle varchar, paramgiro varchar, paramporcentaje varchar, paramporcentajeopt varchar, paramporcentajecual varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_stringbuilder text;
v_lastlevel numeric;
postarrtencasc refcursor;
pistouttype    varchar(20):='DBMS';
listempresaname    varchar(200);
xx_row record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from app_temp_log;
delete from dercorp_reporte_tencasc_tmp;
call dercorp_report_tencasc_pkg_do_report_pr(postarrtencasc, pistouttype, paramempresa);
v_lastlevel := 0;
v_stringbuilder:= null;
begin
select
des_dato2 into strict listempresaname
from
dercorp_reporte_tencasc_tmp
where
des_dato1 = paramempresa;
exception
when others then
null;
end;/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, '{' , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, '   "name": "' , listempresaname , '",' , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, '   "children": [' , chr(10)) ;/* dmap converted statement end */
for xx_row in (with recursive cte as (
select ext.des_dato1,ext.des_dato2,lpad(ext.des_dato3::text, length(ext.des_dato3) + 1 * 5 - 5, ' '::text) as nom_empresa,lpad(' '::text, 5 + 1 * 5 - 5, ' '::text) as pad,ext.des_dato3,ext.des_dato4,ext.des_dato5 directo,ext.des_dato6 indirecto,ext.des_dato7,1 as level,(select
count(*)
from
dercorp_reporte_tencasc_tmp
where
des_dato4 = ext.des_dato1) cant_hijos
from
dercorp_reporte_tencasc_tmp ext
--where
--    ext.des_dato2 like %xezz%
/*
where
(app_common_pkg_get_field_value(516,ext.des_dato1) like % || paramconsolida || %
or app_common_pkg_get_field_value(516,ext.des_dato1) is null)
and
(app_common_pkg_get_field_value(506,ext.des_dato1) like % || paramsegmento || %
or app_common_pkg_get_field_value(506,ext.des_dato1) is null)
and
(app_common_pkg_get_field_value(507,ext.des_dato1) like % || paramclasificacion || %
or app_common_pkg_get_field_value(507,ext.des_dato1) is null)
and
(app_common_pkg_get_field_value(509,ext.des_dato1) like % || parampais || %
or app_common_pkg_get_field_value(509,ext.des_dato1) is null)
and
(app_common_pkg_get_field_value(502,ext.des_dato1) like % || parannumoracle || %
or app_common_pkg_get_field_value(502,ext.des_dato1) is null)
and
(app_common_pkg_get_field_value(504,ext.des_dato1) like % || paramgiro || %
or app_common_pkg_get_field_value(504,ext.des_dato1) is null)
*/
where ext.des_dato4 = paramempresa
union all
select ext.des_dato1,ext.des_dato2,lpad(ext.des_dato3::text, length(ext.des_dato3) + (c.level+1) * 5 - 5, ' '::text) as nom_empresa,lpad(' '::text, 5 + (c.level+1) * 5 - 5, ' '::text) as pad,ext.des_dato3,ext.des_dato4,ext.des_dato5 directo,ext.des_dato6 indirecto,ext.des_dato7,(c.level+1),(select
count(*)
from
dercorp_reporte_tencasc_tmp
where
des_dato4 = ext.des_dato1) cant_hijos
from
dercorp_reporte_tencasc_tmp ext
join cte c on (c.des_dato1 = ext.ext.des_dato4)
) select * from cte)
loop
--if v_lastlevel < xx_row.level then
--    dbms_output.put_line(data:[);
--end if;
-- cerrar el nivel anterior
if v_lastlevel = (xx_row.level + 1) then
v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
--v_stringbuilder := v_stringbuilder || xx_row.pad || ]},;
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '     ]     ' , chr(10)) ;--aaa,,
/* dmap converted statement end *//* dmap converted statement start */
--v_stringbuilder := v_stringbuilder || xx_row.pad || },   || chr(10);
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '},    ' , chr(10)) ;  --ccc ---bbb,,
/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end */
--dbms_output.put_line(xx_row.pad || ]},);
end if;
if v_lastlevel = (xx_row.level + 2) then
v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '     ]}]     ' , chr(10)) ; --acac,,
/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '}, ') ; --aaa --ccc,,
/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end */
--dbms_output.put_line(xx_row.pad || ]},);
end if;
if v_lastlevel = (xx_row.level + 3) then
v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '     ]}     ' , chr(10)) ; --acac,,
/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '}, ') ; --aaa --ccc,,
/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end */
--dbms_output.put_line(xx_row.pad || ]},);
end if;/* dmap converted statement start */
/*
if v_lastlevel > (xx_row.level + 2) then
--v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
--v_stringbuilder := v_stringbuilder || chr(10);
v_stringbuilder := v_stringbuilder || xx_row.pad || }, ;--bbb
v_stringbuilder := v_stringbuilder || chr(10);
--dbms_output.put_line(xx_row.pad || ]},);
end if;
*/
--if xx_row.level = 1 then
--    v_stringbuilder := v_stringbuilder || xx_row.pad || },;
--    v_stringbuilder := v_stringbuilder || chr(10);
--    --dbms_output.put_line(xx_row.pad || ]},);
--end if;
--dbms_output.put_line(
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '{ "name":"' , xx_row.nom_empresa , ' (' , xx_row.indirecto , '%)"') ;/* dmap converted statement end *//* dmap converted statement start */
-- ( || xx_row.directo || % ...  || xx_row.indirecto || %);
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;-- || <br>;
/* dmap converted statement end *//* dmap converted statement start */
if xx_row.cant_hijos > 0 then
--dbms_output.put_line(xx_row.pad || , data:[);
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad  , '   , "children": [' , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
else
v_stringbuilder :=  concat(v_stringbuilder, xx_row.pad , '},') ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, chr(10)) ;/* dmap converted statement end */
end if;
v_lastlevel := xx_row.level;
end loop;
v_stringbuilder := oracle.substr(v_stringbuilder, 1, length(v_stringbuilder)-2);/* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, '     ]' , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
v_stringbuilder :=  concat(v_stringbuilder, '}' , chr(10)) ;/* dmap converted statement end */
--v_stringbuilder := v_stringbuilder || chr(10);
--dbms_output.put_line(a);
--dbms_output.put_line(v_stringbuilder);
--dbms_output.put_line(b);
--retstrdata := v_stringbuilder;
call xxtv_ten_casc_pkg_dump_clob(v_stringbuilder,2);
/* commit; */
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
