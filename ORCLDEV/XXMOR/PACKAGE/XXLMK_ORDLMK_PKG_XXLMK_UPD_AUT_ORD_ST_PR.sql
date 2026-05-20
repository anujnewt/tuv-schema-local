create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_upd_aut_ord_st_pr ( piinordid integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linst_auts integer;
linst_auts_lns integer;
lintm   integer;
lincc   integer;
linnwst integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/*begin
select  nvl(aut.ind_estatus, 1)
into    lintm
from    xxlmk_autorizaciones_tab aut
where   aut.ind_tipo_aut = tm
and     aut.id_orden = piinordid;
exception
when no_data_found then
lintm := -1;
end;
begin
select  nvl(aut.ind_estatus, 1)
into    lincc
from    xxlmk_autorizaciones_tab aut
where   aut.ind_tipo_aut = cc
and     aut.id_orden = piinordid;
exception
when no_data_found then
lincc := -1;
end;
if lintm = -1 and lincc = -1 then
-- no tiene autorizaciones
return;
end if;
if lintm = 1 and lincc = 1 then
-- autorizaciones pendientes
return;
end if;
if lintm = 2 and lincc = 2 then
-- todo autorizado
linnwst := 7;
elsif lintm = 3 and lincc = 3 then
-- todo rechazado
linnwst := 6;
elsif lintm = -1 and lincc = 2 then
linnwst := 7;
elsif lintm = 2 and lincc = -1 then
linnwst := 7;
elsif lintm = -1 and lincc = 3 then
linnwst := 6;
elsif lintm = 3 and lincc = -1 then
linnwst := 6;
elsif lintm = 3 then
-- rechazada tm
linnwst := 4;
elsif lincc = 3 then
-- rechazada cc
linnwst := 5;
end if;
update  xxlmk_ordhdr_tab
set     ind_estatus = linnwst
where   id_ordhdr = piinordid;*/
select  count(*)
into strict    linst_auts
from    xxlmk_autorizaciones_tab    a
where   a.id_orden = piinordid
and     a.ind_nivel = 'E'
and     a.ind_estatus = 3;
if (linst_auts > 0) then
perform dbms_output.put_line('TODAS LAS AUTORIZACIONES RECHAZADAS - SE RECHAZA ORDEN');
update  xxlmk_ordhdr_tab
set ind_estatus = 6
where   id_ordhdr = piinordid;
return;
end if;
select  case
when count(*) = sum(rejected)
then 1
else 0 end as all_rejected
into strict    linst_auts_lns
from (
select  case
when ol.ind_estatus = 4
then 1
else 0 end as rejected
from    xxlmk_ordln_tab ol
where   ol.id_ordhdr = piinordid
) alias2;
if (linst_auts_lns = 1) then
perform dbms_output.put_line('TODAS LAS LINEAS RECHAZADAS - SE RECHAZA ORDEN');
update  xxlmk_ordhdr_tab
set ind_estatus = 6
where   id_ordhdr = piinordid;
return;
end if;
select  case
when count(*) = coalesce(sum(authorized), 0)
then 1
else 0 end as all_authorized
into strict    linst_auts
from (
select  case
when a.ind_estatus = 2
then 1
else 0 end as authorized
from    xxlmk_autorizaciones_tab    a
where   a.id_orden = piinordid
and     a.ind_nivel = 'E'
) alias3;
if (linst_auts = 1) then
perform dbms_output.put_line('TODAS LAS AUTORIZACIONES AUTORIZADAS A NIVEL ENCABEZADO');
select case
when count(*) = sum(authorized)
then 1
else 0 end as all_autorized
into strict    linst_auts_lns
from (
select  case
when a.ind_estatus = 2
then 1
else 0 end as authorized
from    xxlmk_autorizaciones_tab    a
where   a.id_orden = piinordid
and     a.ind_nivel = 'L'
) alias2;
if (linst_auts_lns = 1) then
perform dbms_output.put_line('TODAS LAS AUTORIZACIONES AUTORIZADAS A NIVEL LINEA - CAMBIAR ESTATUS A ORDEN V?LIDA');
update  xxlmk_ordhdr_tab
set     ind_estatus = 7
where   id_ordhdr = piinordid;
return;
end if;
select  count(*)
into strict    linst_auts_lns
from    xxlmk_autorizaciones_tab    a
where   a.id_orden = piinordid
and     a.ind_nivel = 'L'
and     a.ind_estatus = 1;
if (linst_auts_lns = 0) then
perform dbms_output.put_line('NO HAY AUTORIZACIONES PENDIENTES - ACTUALIZAR ESTATUS A ORDEN V?LIDA');
update  xxlmk_ordhdr_tab
set     ind_estatus = 7
where   id_ordhdr = piinordid;
end if;
end if;end;
$body$
language plpgsql
;
