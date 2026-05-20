create or replace procedure usrdrc.xxtv_ten_casc_pkg_get_tree_data_records (resultset inout refcursor, paramempresa varchar, paramfecha varchar, paramconsolida varchar, paramsegmento varchar, paramclasificacion varchar, parampais varchar, parannumoracle varchar, paramgiro varchar, paramporcentaje varchar, paramporcentajeopt varchar, paramporcentajecual varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_stringbuilder text;
v_lastlevel numeric;
postarrtencasc refcursor;
pistouttype    varchar(20):='DBMS';
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--delete from app_temp_log;
----delete from dercorp_reporte_tencasc_fis; solo se usa para debug
--delete from dercorp_reporte_tencasc_tmp;
--call dercorp_report_tencasc_pkg_do_report_pr(postarrtencasc, pistouttype, paramempresa);
open resultset for
--select * from pendium_ten_casc_paso_tmp  order by  id_row;
with recursive cte as (
select super_query_rownum,id_row,id_parent,des_dato1,des_dato2,--nom_empresa,
lpad(ext.des_dato3::text, length(ext.des_dato3) + 1 * 5 - 5, ' '::text) as nom_empresa,--pad,
lpad(' '::text, 5 + 1 * 5 - 5, ' '::text) as pad,des_dato4,directo,indirecto,des_dato7,--ten_casc_level,
1 ten_casc_level,cant_hijos,consolida,segmento,clasificacion,pais,no_emp_oracle,giro,consolida_all,segmento_all,clasificacion_all,pais_all,no_emp_oracle_all,giro_all,division_all,division,array[ row_number() over ( order by   ext.des_dato3) ] as hierarchy
from pendium_ten_casc_paso_tmp ext where ext.des_dato4 = paramempresa
union all
select super_query_rownum,id_row,id_parent,des_dato1,des_dato2,
lpad(ext.des_dato3::text, length(ext.des_dato3) + (c.level+1) * 5 - 5, ' '::text) as nom_empresa,
lpad(' '::text, 5 + (c.level+1) * 5 - 5, ' '::text) as pad,des_dato4,directo,indirecto,des_dato7,
(c.level+1) ten_casc_level,cant_hijos,consolida,segmento,clasificacion,pais,no_emp_oracle,giro,consolida_all,segmento_all,clasificacion_all,pais_all,no_emp_oracle_all,giro_all,division_all,division, array_append(c.hierarchy, row_number() over (order by  ext.des_dato3))  as hierarchy
from pendium_ten_casc_paso_tmp ext join cte c on (c.id_row = ext.ext.id_parent)
) select * from cte order by hierarchy;end;
$body$
language plpgsql
;
