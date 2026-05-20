create or replace procedure usrdrc.dercorp_captura_pkg_recalcular_cam_cap_ecs_pr (piin_id_empresa numeric ,psou_mensaje inout varchar) as $body$
declare
j record;
i record;
-- pgv moved types start
-- pgv moved types end
livalc3               numeric := 0;
livalc4               numeric := 0;
livalnominal          numeric := 0;
livalacciones         numeric;
liexpresnomin         numeric;
livalaccmtb           numeric;
livalc5por            numeric;
livalteonom           numeric;
lincountresplimitada  numeric;
locapvar integer;
locapfij integer;
--ecm 16 agosto 2016
lstvalornominal  varchar(2000);
lstvalorteonomi  varchar(2000);
valoresnominalescur cursor(tiidempresa numeric)
for
select  val_c3
,val_c4
from    dercorp_metatbl_tab
where   1=1
and     id_flex_tbl = 7
and     id_empresa  = tiidempresa
;
valaccmtbcur cursor(tiidempresa numeric)
for
select  id_meta_row
,val_c3
,val_c4
from    dercorp_metatbl_tab
where   1=1
and     id_flex_tbl = 7
and     id_empresa  = tiidempresa
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/*
ecm 27 octubre 2015
recalcular con nuevo valor nominal los campos capitales de
estructuta del capital social
ecm 16 agosto 2016
permitir capturar valores en los campos de
*/
begin
select  val_cat_val
into strict    lstvalornominal
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = (
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = piin_id_empresa
and     id_add_campo = (
select id_add_campo
from   dercorp_add_campo_tab
where  1=1
and    cod_campo = 'C20'
)
)
;
exception
when no_data_found then
lstvalornominal := null;
end;
/*jjaq 16/02/2017 se comenta porque se quito valor teorico nominal
begin
select  val_cat_val
into    lstvalorteonomi
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = (
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = piin_id_empresa
and     id_add_campo = (
select id_add_campo
from   dercorp_add_campo_tab
where  1=1
and    cod_campo = c1076
)
)
;
exception
when no_data_found then
lstvalorteonomi := null;
end;
*/
begin
select
count(*) into strict lincountresplimitada
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = piin_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%RESPONSABILIDAD%LIMITADA%';
exception
when no_data_found then
lincountresplimitada := 0;
end;
if (nullif(lstvalornominal::text, '') is null or
upper(lstvalornominal) like '%SIN%EXPRES%NOMINAL' or
lstvalornominal = 'Valor Desigual'        or
lstvalornominal = 'N/A'
)/*and ( se comenta porque ya no hay valor teorico nominal
lstvalorteonomi is null                   or
lstvalorteonomi = sin expresion nominal or
lstvalorteonomi = valor desigual        or
lstvalorteonomi = n/a
)*/
then
null;
else
select
count(*) into strict liexpresnomin
from
dercorp_add_campo_valor_tab emp
left join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = piin_id_empresa
and
emp.id_add_campo = 519
and (upper(cat.nom_cat_val) like '%SIN%EXPRES%NOMINAL'
or
upper(cat.nom_cat_val) like '%VALOR%DESIGUAL%'
or
upper(cat.nom_cat_val) like '%N/A%'
or
nullif(cat.nom_cat_val::text, '') is null
)
;
--validar que no sea sin expresion nominal. y que no sea s. de r.l.
if liexpresnomin = 0 and lincountresplimitada = 0 then
--obtener valores capital fijo y capital variable
for i in select * from valoresnominalescur(piin_id_empresa)
loop
livalc3 := livalc3 + (coalesce(i.val_c3, '0'))::numeric;
livalc4 := livalc4 + (coalesce(i.val_c4, '0'))::numeric;
end loop;
--obtener valornominal
select (
select  (replace(replace(val_cat_val, '$', ''), ',', ''))::numeric
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = val_valor
)
into strict    livalnominal
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 519
and     id_empresa = piin_id_empresa
;
--actualizar campos con valor nominal nuevo.
livalc3 := livalc3 * livalnominal;
livalc4 := livalc4 * livalnominal;
livalacciones := livalc3 + livalc4;/* dmap converted statement start */
perform dbms_output.put_line( concat(livalc3, ' ', livalc4, ' ', livalacciones)) ;/* dmap converted statement end */
call dercorp_flextab_pkg_get_check_cap_fij_var_pr(locapvar, locapfij, (piin_id_empresa)::numeric );
--actualiza el campo capital fijo o minimo
if locapfij > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor = livalc3
where   1=1
and     id_add_campo = 1028
and     id_empresa = piin_id_empresa
;
end if;
--actualiza el campo capital variable
if locapvar > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor = livalc4
where   1=1
and     id_add_campo = 1029
and     id_empresa = piin_id_empresa
;
end if;
--suma campo capital fijo o minimo + capital variable
if locapfij > 0 or locapvar > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor = livalacciones
where   1=1
and     id_add_campo = 541
and     id_empresa = piin_id_empresa
;
end if;
for j in select * from valaccmtbcur(piin_id_empresa)
loop
--   if ( (j.val_c3 is not null) and (j.val_c4 is not null) ) then
--    livalaccmtb := to_number(j.val_c3)*livalnominal + to_number(j.val_c4)*livalnominal;
-- jams se comenta el if y se agrega un nvl a la suma de la multiplicacion al valor nominal 10/07/2018
livalaccmtb := (coalesce(j.val_c3::text, '0'))::numeric *livalnominal + (coalesce(j.val_c4, '0'))::numeric *livalnominal;
update dercorp_metatbl_tab
set    val_c6 = livalaccmtb
where  1=1
and    id_meta_row = j.id_meta_row
;
--   end if;
end loop;
/*
--valor teorico nominal campo 1076
elsif liexpresnomin > 0 then
--obtener valores capital fijo y capital variable
for i in select * from valoresnominalescur(piin_id_empresa)
loop
livalc3 := livalc3 + to_number(nvl(i.val_c3::numeric, 0));
livalc4 := livalc4 + to_number(nvl(i.val_c4::numeric, 0));
end loop;
livalteonom := 0;
begin
--obtener valor teorico nominal
select    to_number(replace(replace(val_cat_val, $, ), ,, ))
into      livalteonom
from      dercorp_add_campo_cat_val_tab
where     1=1
and       id_catalogo = 9
and       id_catalogo_valor = (
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 1076
and     id_empresa = piin_id_empresa
)
;
exception
when others then
livalteonom := 0;
end;
--actualizar campos con valor toerico nominal nuevo.
livalc3 := livalc3 * to_number(nvl(livalteonom::numeric, 0));
livalc4 := livalc4 * to_number(nvl(livalteonom::numeric, 0));
livalacciones := livalc3 + livalc4;
update  dercorp_add_campo_valor_tab
set     val_valor = livalc3
where   1=1
and     id_add_campo = 1028
and     id_empresa = piin_id_empresa
;
update  dercorp_add_campo_valor_tab
set     val_valor = livalc4
where   1=1
and     id_add_campo = 1029
and     id_empresa = piin_id_empresa
;
update  dercorp_add_campo_valor_tab
set     val_valor = livalacciones
where   1=1
and     id_add_campo = 541
and     id_empresa = piin_id_empresa
;
--actulizar la metatable.
for j in select * from valaccmtbcur(piin_id_empresa)
loop
if( (nullif(j.val_c3::text, '') is not null) and (nullif(j.val_c4::text, '') is not null)
and (livalteonom > 0) )then
livalaccmtb := to_number(j.val_c3)*livalteonom + to_number(j.val_c4)*livalteonom;
update dercorp_metatbl_tab
set    val_c6 = livalaccmtb
where  1=1
and    id_meta_row = j.id_meta_row
;
end if;
end loop;
*/
else
--se repite de lo que hay arriba para que recalcule con valor nominal a 1 cuando no sea numero
livalnominal := 1;
--actualizar campos con valor nominal nuevo.
livalc3 := livalc3 * livalnominal;
livalc4 := livalc4 * livalnominal;
livalacciones := livalc3 + livalc4;/* dmap converted statement start */
perform dbms_output.put_line( concat(livalc3, ' ', livalc4, ' ', livalacciones)) ;/* dmap converted statement end */
call dercorp_flextab_pkg_get_check_cap_fij_var_pr(locapvar, locapfij, (piin_id_empresa)::numeric );
--actualiza el campo capital fijo o minimo
if locapfij > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor = livalc3
where   1=1
and     id_add_campo = 1028
and     id_empresa = piin_id_empresa
;
end if;
--actualiza el campo capital variable
if locapvar > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor = livalc4
where   1=1
and     id_add_campo = 1029
and     id_empresa = piin_id_empresa
;
end if;
--suma campo capital fijo o minimo + capital variable
if locapfij > 0 or locapvar > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor = livalacciones
where   1=1
and     id_add_campo = 541
and     id_empresa = piin_id_empresa
;
end if;
for j in select * from valaccmtbcur(piin_id_empresa)
loop
--  if ( (j.val_c3 is not null) and (j.val_c4 is not null) ) then
livalaccmtb := (coalesce(j.val_c3, '0'))::numeric *livalnominal + (coalesce(j.val_c4, '0'))::numeric *livalnominal;
-- jams se comenta el if y se agrega un nvl a la suma de la multiplicacion al valor nominal 10/07/2018
update dercorp_metatbl_tab
set    val_c6 = livalaccmtb
where  1=1
and    id_meta_row = j.id_meta_row
;
--    end if;
end loop;
end if;
/* commit; */
end if;/* dmap converted statement start */
exception
when no_data_found then
perform dbms_output.put_line( concat('No encontro datos con la empresa: ', piin_id_empresa)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('ORA-ERROR: ', sqlstate)) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);/* dmap converted statement start */
psou_mensaje :=  concat(sqlerrm, ' ', sqlstate) ;/* dmap converted statement end *//* dmap converted statement start */
when others then
perform dbms_output.put_line( concat('ORA-ERROR: ', sqlstate)) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);/* dmap converted statement start */
psou_mensaje :=  concat(sqlerrm, ' ', sqlstate) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
