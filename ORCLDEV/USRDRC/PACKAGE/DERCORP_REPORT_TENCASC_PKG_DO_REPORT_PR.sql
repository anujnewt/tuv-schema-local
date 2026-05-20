create or replace procedure usrdrc.dercorp_report_tencasc_pkg_do_report_pr ( postarrtencasc inout refcursor , pistouttype varchar , pistempresa varchar) as $body$
declare
get_niveles_hijos record;
get_info record;
-- pgv moved types start
-- pgv moved types end
-- inicio - declaracion de variables locales
lrcdata     refcursor;
lstdesdato6 varchar(20);
lincontador varchar(10):=0;
linsum      varchar(10):=0;with recursive cte as (
-- fin - declaracion de variables locales
-- cursor para calcular porcentajes directos e indirectos
cur_calc_porc_indirecto  cursor(piinidempresa numeric)
for
select des_dato1, des_dato2, lpad(des_dato2::text, length(des_dato2) + 1 * 5 - 5, ' '::text) as nom_empresa, des_dato4, des_dato5, des_dato6, 1 as level
from   usrdrc.dercorp_reporte_tencasc_tmp where des_dato4       = piinidempresa
union all
cur_calc_porc_indirecto cursor(piinidempresa numeric)
for
select des_dato1, des_dato2, lpad(des_dato2::text, length(des_dato2) + (c.level+1) * 5 - 5, ' '::text) as nom_empresa, des_dato4, des_dato5, des_dato6, (c.level+1)
from   usrdrc.dercorp_reporte_tencasc_tmp join cte c on (c.des_dato1 = des_dato4)
) select * from cte;
-- recupera niveles mayores a 1
cur_niveles cursor for
select des_dato1, des_dato7
from   usrdrc.dercorp_reporte_tencasc_tmp
group by des_dato1, des_dato7
having count(des_dato1) > 1;
-- recupera los registros de los
-- niveles mayores a 1
cur_niveles_hijos cursor(
pinpadre numeric, piilevel numeric
)
for
select distinct des_dato1, des_dato4, des_dato5
from   usrdrc.dercorp_reporte_tencasc_tmp
where  des_dato1                          = pinpadre
and    des_dato7                          = piilevel;
-- recupera registros los cuales tienen
-- mas de una empresa padre en un nivel diferente
-- del arbol.
cur_multiple cursor for
select des_dato1
from   usrdrc.dercorp_reporte_tencasc_tmp
where  nullif(des_dato8::text, '') is null
group by des_dato1
having count(des_dato1) > 1;
--dmap conversion comment: global temp variables moved as local temp variables
gincountarr_temp numeric;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('USRDRC', 'DERCORP_REPORT_TENCASC_PKG');
--dmap conversion comment: gtt declaration added
execute 'alter session set nullif(nls_numeric_characters::text, '') is null. ;' ; /* dmap converted statement */
call dercorp_report_tencasc_pkg_print_message_pr(pistouttype, 'Inicia proceso ...');/* dmap converted statement start */
call dercorp_report_tencasc_pkg_print_message_pr(pistouttype,  concat('Hora: ', to_char(clock_timestamp(), 'DD-MON-RRRR HH24:MI:SS'))) ;/* dmap converted statement end */
-- inserta el registro de la empresa base
insert into usrdrc.dercorp_reporte_tencasc_tmp(
des_dato1
,des_dato2
,des_dato3
)
select
id_empresa
,nom_empresa
,nom_empresa
from   dercorp_empresa_tab
where  id_empresa          = pistempresa;
call dmap_extension.p_dmap_set_pkg_var('USRDRC' , 'DERCORP_REPORT_TENCASC_PKG', 'GINCOUNTARR', 'NUMBER',(0)::text, 'N');
-- insert code here
call dercorp_report_tencasc_pkg_get_refcursor_pr(pistempresa => pistempresa);
open lrcdata
for  select  row_number() over () as row_num
,des_dato1,des_dato2,des_dato3
,des_dato4,des_dato5,des_dato6
,des_dato7,des_dato8,des_dato9
,des_dato10
from    usrdrc.dercorp_reporte_tencasc_tmp;
postarrtencasc := lrcdata;
/* commit; */
-- actualiza el % indirecto con el mismo valor del % directo
-- para las empresas del primer nivel
for get_info in select * from cur_calc_porc_indirecto(pistempresa)
loop
-- actualiza el campo des_dato7 con el nivel
-- que le corresponde a cada registro
update usrdrc.dercorp_reporte_tencasc_tmp
set    des_dato7          =  get_info.level
where  des_dato1          =
get_info.des_dato1
and    des_dato4          =
get_info.des_dato4;/* dmap converted statement start */
-- actualiza solo sobre los niveles 1
if get_info.level = 1
then
update usrdrc.dercorp_reporte_tencasc_tmp
set    des_dato6                         =
rtrim(ltrim(to_char(des_dato5::text,'999.999999')))
where  des_dato4                         =
get_info.des_dato4;/* dmap converted statement end */
end if;
end loop;
/* commit; */
-- registros mayores a nivel 1
for get_niveles in cur_niveles
loop
for get_niveles_hijos in select * from cur_niveles_hijos(get_niveles.des_dato1,get_niveles.des_dato7)
loop
lstdesdato6 := null;
-- recupera el % indirecto del nivel superior
begin
select des_dato6
into strict   lstdesdato6
from   usrdrc.dercorp_reporte_tencasc_tmp
where  des_dato1                         =
get_niveles_hijos.des_dato4;
exception
when no_data_found
then
call dercorp_report_tencasc_pkg_print_message_pr('DBMS', '1.- No se encontro el % indirecto del nivel superior');
when too_many_rows
then
call dercorp_report_tencasc_pkg_print_message_pr('DBMS', '1.- Se encontraron mas de un registro en la consulta.');
end;/* dmap converted statement start */
-- actualiza registros que tienen mas de una empresa base
-- en un nivel superior inmediato
-- y el campo des_dato8 con el valor de y para identificar estos casos.
update usrdrc.dercorp_reporte_tencasc_tmp
set    des_dato6 = coalesce(des_dato6,0) +
rtrim(ltrim(to_char((get_niveles_hijos.des_dato5 * coalesce(lstdesdato6::text,0)) / 100,'999.999999')))
,des_dato8 = 'Y'
where  des_dato1 =
get_niveles_hijos.des_dato1;/* dmap converted statement end */
end loop;
end loop;
/* commit; */
-- recupera todos los registros del arbol
for get_info in select * from cur_calc_porc_indirecto(pistempresa)
loop
lstdesdato6 := null;
linsum      := null;
-- recupera el % indirecto del nivel superior
begin
select des_dato6
into strict   lstdesdato6
from   usrdrc.dercorp_reporte_tencasc_tmp
where  des_dato1                         =
get_info.des_dato4  limit 1;
exception
when no_data_found
then
call dercorp_report_tencasc_pkg_print_message_pr('DBMS', '2.- No se encontro el % indirecto del nivel superior');
when too_many_rows
then
call dercorp_report_tencasc_pkg_print_message_pr('DBMS', '2.- Se encontraron mas de un registro en la consulta.');
end;/* dmap converted statement start */
-- actualiza el valor del % indirecto para los registros
-- que aun no tienen este calculo.
update usrdrc.dercorp_reporte_tencasc_tmp
set    des_dato6 =
rtrim(ltrim(to_char((get_info.des_dato5 * lstdesdato6) / 100::text,'999.999999')))
where  des_dato1 =
get_info.des_dato1
and    des_dato4 =
get_info.des_dato4
and    nullif(des_dato6::text, '') is null;/* dmap converted statement end */
end loop;
-- recupera registros los cuales tienen
-- mas de una empresa padre en un nivel diferente
-- del arbol.
for j in cur_multiple
loop
linsum := null;
-- recupera la suma de los % indirectos
-- de los registros que tienen mas de una empresa padre
-- en diferente nivel del arbol.
select sum(des_dato6)
into strict   linsum
from   usrdrc.dercorp_reporte_tencasc_tmp
where  des_dato1                          = j.des_dato1;
-- actualiza el % indirecto de
-- de los registros que tienen mas de una empresa padre
-- en diferente nivel del arbol.
update usrdrc.dercorp_reporte_tencasc_tmp
set    des_dato6                          = linsum
where  des_dato1                          = j.des_dato1;
end loop;/* dmap converted statement start */
--nava
/*
delete from dercorp_reporte_tencasc_fis;
insert into dercorp_reporte_tencasc_fis
select * from dercorp_reporte_tencasc_tmp;
*/
-- end nava
/* commit; */
call dercorp_report_tencasc_pkg_print_message_pr(pistouttype,  concat('Hora: ', to_char(clock_timestamp(), 'DD-MON-RRRR HH24:MI:SS'))) ;/* dmap converted statement end */
call dercorp_report_tencasc_pkg_print_message_pr(pistouttype, 'Termina proceso ...');/* dmap converted statement start */
exception
when others
then
call dercorp_report_tencasc_pkg_print_message_pr(pistouttype,  concat('ERROR: ', sqlerrm)) ;/* dmap converted statement end *//* dmap converted statement start */
call dercorp_report_tencasc_pkg_print_message_pr(pistouttype,  concat('Hora: ', to_char(clock_timestamp(), 'DD-MON-RRRR HH24:MI:SS'))) ;/* dmap converted statement end */
call dercorp_report_tencasc_pkg_print_message_pr(pistouttype, 'Termina proceso ...');end;
$body$
language plpgsql
;
