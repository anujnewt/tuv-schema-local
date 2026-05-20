create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_es_orden_facturable_fn ( piinidsolicitud integer ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
lst_sufijo         varchar(2);
lin_facturable     integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
lst_sufijo := null;
begin
select oracle.substr(trim(both mcontid),position('.' in trim(both mcontid))-2,2) sufijo
into strict   lst_sufijo
from   xxmor_solicitudes_enc_tab e
where  id_seg_neg   = 1
and    id_solicitud = piinidsolicitud;
exception
when others then
lst_sufijo := null;
end;
if nullif(lst_sufijo::text, '') is not null then
begin
select case when count(idprefix) = 0 then 1 else 0 end facturable
into strict   lin_facturable
from   sayco_304.sm_ordersprefix__ordunidb2
where  upper(idprefix) = upper(lst_sufijo);
exception
when others then
lin_facturable := 2;
end;
else
lin_facturable := 2;
end if;
return lin_facturable;
exception
when no_data_found then
return 2;
when others then
return 2;end;
$body$
language plpgsql
;
