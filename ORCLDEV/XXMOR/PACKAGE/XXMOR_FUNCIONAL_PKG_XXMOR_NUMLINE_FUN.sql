create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_numline_fun ( p_id_solicitud integer, p_linea integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_count            integer;
v_numline          varchar(4);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select count(1)
into strict   v_count
from (select version,
stnid,
count(version),
case
when count(version) = 1 then
min(linea)
else 0 end
as numline
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
--and linea = 1
group by version, stnid
) alias4
where  numline = p_linea;
if v_count = 0 then
v_numline := '000';
else
select lpad((select estat_id_foraneo
from   xxmor_solicitudes_est_rep_tab
where  id_solicitud =  p_id_solicitud
and    linea        = numline
)::text, 3, '0'::text) as numline
into strict   v_numline
from (select version,
stnid,
count(version),
case
when count(version) = 1 then
min(linea)
else 0 end
as numline
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud
--and linea = 1
group by version, stnid
) alias5
where numline = p_linea;
/*select lpad(to_char(numline)::text, 3, 0::text)
into v_numline
from (
select version,stnid, count(version),
case when count(version) = 1
then min (linea) else 0 end
as numline
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud
--and linea = 1
group by version, stnid)
where numline = p_linea;*/
end if;
return v_numline;end;
$body$
language plpgsql
;
