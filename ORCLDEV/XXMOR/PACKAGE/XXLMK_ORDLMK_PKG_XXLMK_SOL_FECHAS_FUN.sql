create or replace  function  xxmor.xxlmk_ordlmk_pkg_xxlmk_sol_fechas_fun ( p_id_solicitud integer, p_linea integer, p_tipo varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_total     varchar(100);
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if p_tipo = 'F_1A_T' then
begin
select to_char(to_timestamp(des_fec_ini,'yyyymmdd')
,0+,0  case
when can_lun != 0 then 0
when can_mar != 0 then 1
when can_mie != 0 then 2
when can_jue != 0 then 3
when can_vie != 0 then 4
when can_sab != 0 then 5
when can_dom != 0 then 6
else null
end,'YYYYMMDD')
into strict    v_total
from    xxlmk_ordln_tab
where   id_ordhdr = p_id_solicitud
and     num_linea = p_linea;/* dmap converted statement end */
exception
when others then
v_total := '00010101';
end;/* dmap converted statement start */
elsif p_tipo = 'F_U_T' then
begin
select to_char(to_timestamp(des_fec_fin,'yyyymmdd')
,0-,0  case
when can_dom != 0 then 0
when can_sab != 0 then 1
when can_vie != 0 then 2
when can_jue  != 0 then 3
when can_mie != 0 then 4
when can_mar != 0 then 5
when can_lun != 0 then 6
else null
end,'YYYYMMDD')
into strict    v_total
from    xxlmk_ordln_tab
where   id_ordhdr = p_id_solicitud
and     num_linea = p_linea;/* dmap converted statement end */
exception
when others then
v_total := '00010101';
end;
end if;
return v_total;end;
$body$
language plpgsql
stable;
