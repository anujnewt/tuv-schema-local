create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_updt_ord_st_spots (piinord_id numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linspts_repr numeric := 0;
linspts_rech numeric := 0;
linspts_ok   numeric := 0;
linst_ord numeric;
linnw_st_ord numeric;
linnum_spots numeric := 0;
lstst varchar(200);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select  ind_estatus
into strict    linst_ord
from    xxlmk_ordhdr_tab    o
where   o.id_ordhdr = piinord_id;
select  count(*)
into strict    linspts_repr
from    xxlmk_ordln_tab ol
join    xxlmk_lineas_spots_tab ls
on      ol.id_linea = ls.id_linea
where   ls.ind_estatus = 6
and     ol.id_ordhdr = piinord_id;
select  count(*)
into strict    linspts_rech
from    xxlmk_ordln_tab ol
join    xxlmk_lineas_spots_tab ls
on      ol.id_linea = ls.id_linea
where   ls.ind_estatus = 4
and     ol.id_ordhdr = piinord_id;
select  count(*)
into strict    linnum_spots
from    xxlmk_ordln_tab ol
join    xxlmk_lineas_spots_tab ls
on      ol.id_linea = ls.id_linea
and     ol.id_ordhdr = piinord_id;
select  case
when linspts_repr > 0 and linspts_rech = 0 then 10
--when linspts_repr = 0 and linspts_rech > 0 then 11
when linspts_repr > 0 and linspts_rech > 0 then 12
when linspts_repr = 0 and linspts_rech = 0 then 100
when linspts_rech = linnum_spots then 6 -- todas las lineas rechazadas -> orden rechazada
else  linst_ord
end as st_ord
into strict    linnw_st_ord
;
if (linnw_st_ord = 100) then
select  count(*)
into strict    linspts_ok
from    xxlmk_ordln_tab ol
join    xxlmk_lineas_spots_tab ls
on      ol.id_linea = ls.id_linea
where   ls.ind_estatus = 7
and     ol.id_ordhdr = piinord_id;
if (linspts_ok != linnum_spots) then
linnw_st_ord := linst_ord;
end if;
end if;
update  xxlmk_ordhdr_tab    o
set     ind_estatus = linnw_st_ord
where   o.id_ordhdr = piinord_id;
select case linnw_st_ord
when 10 then 'ORDEN CON REPROCESOS'
when 11 then 'ORDEN CON RECHAZOS'
when 12 then 'ORDEN CON REPROCESOS Y RECHAZOS'
when 100 then 'ORDEN COMPLETA'
else 'NO HAY CAMBIO DE ESTATUS'
end
into strict    lstst
;/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTATUS: ', lstst)) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
