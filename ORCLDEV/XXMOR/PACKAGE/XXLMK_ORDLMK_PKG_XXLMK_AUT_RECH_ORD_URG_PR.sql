create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_aut_rech_ord_urg_pr ( piinnum_ord numeric, a_lineas array_tvch2, piintam_arr numeric, piinind_aut_rech numeric, pistuser varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linind_st_linea    numeric;
linind_st_ord      numeric;
linid_linea        integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if (piintam_arr > 0) then
for i in 1..piintam_arr loop
update  xxlmk_autorizaciones_tab
set ind_estatus         = piinind_aut_rech,
fec_actualizacion   = clock_timestamp(),
cve_actualizado_por = pistuser
where   id_orden    = piinnum_ord
and     num_linea   = (a_lineas(i))::numeric
and     ind_tipo_aut = 'URG';
select  id_linea
into strict    linid_linea
from    xxlmk_ordln_tab
where   id_ordhdr   = piinnum_ord
and     num_linea   = (a_lineas(i))::numeric;
if (piinind_aut_rech = 2) then
select  count(*)
into strict    linind_st_linea
from    xxlmk_autorizaciones_tab a
where   a.id_orden = piinnum_ord
and     a.num_linea = (a_lineas(i))::numeric
and     a.ind_nivel = 'L'
and     a.ind_estatus = 1;
if (linind_st_linea = 0) then
update    xxlmk_ordln_tab
set ind_estatus = 5
where   id_ordhdr   = piinnum_ord
and     num_linea   = (a_lineas(i))::numeric;
update  xxlmk_lineas_spots_tab
set     ind_estatus = 5
where   id_linea = linid_linea;
end if;
/*select  count(*)
into    linind_st_ord
from    xxlmk_autorizaciones_tab    a
where   a.id_orden = piinnum_ord
and     a.num_linea = to_number(a_lineas(i))
and     a.ind_nivel = e
and     a.ind_estatus = 1;
if(linind_st_ord = 0) then
update  xxlmk_ordhdr_tab
set ind_estatus = 7
where   id_ordhdr = piinnum_ord;
end if;*/
elsif (piinind_aut_rech = 3) then
update    xxlmk_ordln_tab
set ind_estatus = 4
where   id_ordhdr   = piinnum_ord
and     num_linea   = (a_lineas(i))::numeric;
update  xxlmk_lineas_spots_tab
set     ind_estatus = 4
where   id_linea = linid_linea;
/*select  count(*)
into    linind_st_ord
from    xxlmk_ordln_tab ol
where   ol.id_ordhdr = piinnum_ord
and
(ol.ind_estatus = 3
or  ol.ind_estatus = 5);
if(linind_st_ord = 0) then
update  xxlmk_ordhdr_tab
set     ind_estatus = 6
where   id_ordhdr = piinnum_ord;
end if;*/
end if;
end loop;
call xxlmk_ordlmk_pkg_xxlmk_upd_aut_ord_st_pr(piinnum_ord);
/* commit; */
end if;end;
$body$
language plpgsql
;
