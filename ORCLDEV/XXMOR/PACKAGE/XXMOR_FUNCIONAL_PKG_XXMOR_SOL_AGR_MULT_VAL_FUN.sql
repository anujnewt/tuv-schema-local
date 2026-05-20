create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_sol_agr_mult_val_fun ( p_id_solicitud integer ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_conf_agr_mult         integer;
v_ord_num_ord_hnas      integer;
v_ord_con_gr_ca         integer;
v_ord_sin_gr_ca         integer;
v_ord_sin_gr_ca_aux     integer := 0;
v_return                integer;
solicitudes_cur cursor for
select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select count(agrupador_multiple) as agrupadormultiple
into strict v_conf_agr_mult
from xxmor_cat_agrupador_mult_tab
where agrupador_multiple = (select agrupador
from   xxmor.xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
);
if v_conf_agr_mult > 1 then
for c_solicitud in solicitudes_cur loop
select count(1)
into strict   v_ord_con_gr_ca
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d
where e.id_solicitud = d.id_solicitud
and   e.id_solicitud = c_solicitud.id_solicitud
and   not exists (select 1 -- las lineas de detalle que no han sido rechazadas
from   xxmor_concom_rpta_tab cr
where  cr.id_seg_neg                 = 1
and    nullif(cr.numlinea_concom::text, '') is not null
and    cr.accion_concom              = 'RECHAZO'
and    cr.estatus_orduni             = '10'
and    cr.id_solicitud               = d.id_solicitud
and    (cr.numlinea_concom)::numeric  = d.linea
)
and   coalesce(d.getrate_con_ajuste,0) > 0
;/* dmap converted statement start */
--and   r.id_solicitud = d.id_solicitud
--and   r.linea = d.linea
--and   r.estat_id_foraneo is null
--and   d.getrate_con_ajuste is not null; -- se quito esta condicion pues hay lineas que el ws retorna 0
perform dbms_output.put_line( concat('V_ORD_CON_GR_CA: ', v_ord_con_gr_ca)  );/* dmap converted statement end */
if v_ord_sin_gr_ca_aux = v_ord_con_gr_ca and  v_ord_con_gr_ca != 0 then
v_return := 1;
else
v_return := 0;
end if;
v_ord_sin_gr_ca_aux := v_ord_con_gr_ca;
end loop;
else
v_return := 1;
end if;
return v_return;end;
$body$
language plpgsql
;
