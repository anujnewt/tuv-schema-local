create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_rtcrd_ca_fun ( p_id_solicitud integer ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_resultado    integer;
v_fec_inicio   varchar(12);
v_rtcrddscr    varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
begin
select to_char(min(to_timestamp(fecha_inicio,'YYYYMMDD')),'YYYY-MM-DD')
into strict   v_fec_inicio
from   xxmor_solicitudes_det_tab d
where  d.id_solicitud = p_id_solicitud
and    exists (select 1
from   xxmor_solicitudes_enc_tab e
where  e.id_solicitud = d.id_solicitud
and    e.id_seg_neg   = 1
)
and    not exists (-- se agrego para no considerar lineas rechazadas 14-08-2013
select 1
from   xxmor_concom_rpta_tab crt
where  nullif(crt.numlinea_concom::text, '') is not null
and    crt.estatus_orduni             = '10'
and    upper(crt.accion_concom)       = 'RECHAZO'
and    crt.id_solicitud               = d.id_solicitud
and    (crt.numlinea_concom)::numeric  = d.linea
);
exception
when others then
v_fec_inicio := '1900-01-01';
end;
if nullif(v_fec_inicio::text, '') is null then
v_fec_inicio := '1900-01-01';
end if;
begin
select rtcrddscr
into strict   v_rtcrddscr
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud;
exception
when others then
v_rtcrddscr :='NO_RT';
end;
--dbms_output.put_line(-> ||v_rtcrddscr);
--dbms_output.put_line(-> ||v_fec_inicio);
if nullif(v_rtcrddscr::text, '') is null or nullif(v_rtcrddscr::text, '') is null  then
v_resultado := 0;
elsif v_rtcrddscr != 'NO_RT' then
select count(1) as ca_rtcrd
into strict   v_resultado
from   eventas.ca_ratecards__ordunidb2
where  rtcrddscr = v_rtcrddscr
and    v_fec_inicio between strdt and edt;
else
v_resultado := 0;
end if;
return v_resultado;end;
$body$
language plpgsql
;
