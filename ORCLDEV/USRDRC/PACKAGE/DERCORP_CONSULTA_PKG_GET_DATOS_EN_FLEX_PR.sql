create or replace procedure usrdrc.dercorp_consulta_pkg_get_datos_en_flex_pr ( piinidflex numeric ,piinidvalor varchar ,poutresultado inout numeric ) as $body$
declare
u record;
-- pgv moved types start
-- pgv moved types end
v_cadena_sql          varchar(5000);
rsresultado           refcursor;
lincount              numeric := 0;
lincoincidencias      numeric := 0;
/*
cursor query_id_flexs_cur
is
select id_flex_tbl
from dercorp_flex_tbls_tab
where attribute_category is null;
*/
query_colums_flex cursor(
piinidflex numeric
)
for
/*select cod_flex_colum
from dercorp_flex_colums_tab
where id_flex_tbl  = piinidflex
and des_tipo_colum =select;*/
select cod_flex_colum,id_flex_tbl
from dercorp_flex_colums_tab
where id_flex_tbl in (select id_flex_tbl from dercorp_flex_tbls_tab where id_flex_tbl not in (17,18))
and des_tipo_colum ='SELECT';
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
-- for i in query_id_flexs_cur
-- loop
for u in select * from query_colums_flex(piinidflex)
loop
perform dbms_output.put_line( concat('U.ID_FLEX_TBL: ', u.id_flex_tbl)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('piinIdValor: ', piinidvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('u.COD_FLEX_COLUM: ', u.cod_flex_colum)) ;/* dmap converted statement end *//* dmap converted statement start */
v_cadena_sql :=  concat('SELECT COUNT(1) FROM DERCORP_METATBL_TAB WHERE ID_FLEX_TBL = (U.ID_FLEX_TBL)::numeric AND u.COD_FLEX_COLUM = ', piinidvalor , '') ; /* dmap converted statement end *//* dmap converted statement */
--and val_c5 = to_char(18100);
open rsresultado for execute v_cadena_sql;
loop
fetch rsresultado into lincount;
exit when not found; /* apply on rsresultado */
if lincount > 0
then
lincoincidencias := lincoincidencias + lincount;
end if;
end loop;
poutresultado := lincoincidencias;
end loop;
--  end loop;
end;
$body$
language plpgsql
;
