create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_get_rtcrd_agr_mult_fn ( p_id_solicitud numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_rtcrddscr     varchar(50);
v_es_de_ca      integer;
v_rtcrd         varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
v_es_de_ca :=  xxmor_funcional_pkg_xxmor_rtcrd_ca_fun(p_id_solicitud);
if v_es_de_ca = 1 then
select replace(e.rtcrddscr, am.ca_rtcrd_substr, am.ca_rtcrd_aux)
into strict   v_rtcrddscr
from   xxmor_solicitudes_enc_tab    e,
xxmor_cat_agrupador_mult_tab am
where  e.id_solicitud   = p_id_solicitud
and    e.agrupador      = am.agrupador_multiple
and    am.prefijo_canal = (select oracle.substr(d.stnid,0,2)
from   xxmor_solicitudes_det_tab d
where  d.id_solicitud = e.id_solicitud
limit 1);
select trim(both rtcrd)
into strict   v_rtcrd
from   eventas.ca_ratecards__ordunidb2
where  rtcrddscr = v_rtcrddscr;
else
--obtiene el rtcard del canal de cable o sky
select replace(e.rtcrddscr, am.rtcrd_substr, prefijo_canal)
into strict   v_rtcrddscr
from   xxmor_solicitudes_enc_tab    e,
xxmor_cat_agrupador_mult_tab am
where  e.id_solicitud   = p_id_solicitud
and    e.agrupador      = am.agrupador_multiple
and    am.prefijo_canal = (select oracle.substr(stnid,0,2)
from   xxmor_solicitudes_det_tab d
where  d.id_solicitud = e.id_solicitud
limit 1);
select trim(both rtcrd)
into strict   v_rtcrd
from   paradb.rthdr__ordunidb2
where  rtcrddscr = v_rtcrddscr;
end if;
return v_rtcrd;
exception
when no_data_found then
return null;
when too_many_rows then
return null;
when others then
return null;end;
$body$
language plpgsql
;
