create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_desc_mcontid_fun ( p_id_solicitud integer ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_mcontid       varchar(50);
v_descuento     numeric;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select mcontid
into strict   v_mcontid
from   xxmor_solicitudes_enc_tab
where  id_solicitud =  p_id_solicitud;
begin
select trunc((1-discval/10000),2) --1-discval/10000 con este valor no regresaba el valor correcto
into strict   v_descuento
from   paradb.mcont__ordunidb2
where  mcontid = v_mcontid;
exception
when no_data_found then
v_descuento := 1;
end;
return v_descuento;end;
$body$
language plpgsql
;
