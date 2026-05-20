create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_revisar_buyunitmkt_pr ( p_id_solicitud xxmor_solicitudes_enc_tab.id_solicitud%type ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_esmkt            char(1):='0';
v_buyunit_tmp      xxmor_solicitudes_det_tab.buyuntid%type;
v_gerentetmp       varchar(100);
v_gerentemkt       varchar(100);
v_id_fza_ventas    integer;
v_resultado        integer:=1;
buyunitmkt_cur cursor for
select id_solicitud,
buyuntid
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select coalesce(aut_x_correo,'0')
into strict   v_esmkt
from   xxmor_fzas_vtas_tab
where  id_fza_ventas = (select id_fza_ventas
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
);/* dmap converted statement start */
perform dbms_output.put_line( concat('antes de entrar al if esMkt(Aut)correo: ', v_esmkt)  );/* dmap converted statement end *//* dmap converted statement start */
if v_esmkt = '1' then
perform dbms_output.put_line( concat('v_EsMkt: ', v_esmkt)  );/* dmap converted statement end */
select id_fza_ventas
into strict   v_id_fza_ventas
from   xxmor_solicitudes_enc_tab se
where  id_solicitud = p_id_solicitud;
begin
select mkt_mail_coordinador
into strict   v_gerentemkt
from   xxmor_cat_buyunit_mkt_tab
where  id_seg_neg    = 1
and    id_fza_ventas = v_id_fza_ventas
and    buyuntid      = (select buyuntid
from   xxmor_solicitudes_det_tab where    id_solicitud = p_id_solicitud
limit 1);
exception
when no_data_found then
v_gerentemkt :=  null;
v_resultado  := 0;
end;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_GerenteMkt: ', v_gerentemkt)  );/* dmap converted statement end */
if nullif(v_gerentemkt::text, '') is not null then
--se compara linea a linea los coordinadores de mkt para verificar q sean el mismo en todas las lineas
for c_buyunit in buyunitmkt_cur loop
select mkt_mail_coordinador
into strict   v_gerentetmp
from   xxmor_cat_buyunit_mkt_tab
where  id_seg_neg    = 1
and    id_fza_ventas = v_id_fza_ventas
and    buyuntid      = c_buyunit.buyuntid;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_GerenteTmp: ', v_gerentetmp)  );/* dmap converted statement end */
if v_gerentetmp != v_gerentemkt or v_resultado = 0 then
v_resultado := 0;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_RESULTADO: ', v_resultado)  );/* dmap converted statement end */
end if;
end loop;
end if;
--si las lineas de la orden tienen diferente coordinador de mkt se rechaza la orden, usando la tabla de rpta concom
if v_resultado = 0 and nullif(v_gerentemkt::text, '') is not null then
perform dbms_output.put_line('-->Se rechaza la orden!!!');
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom,
resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom,
estatus_concom, campo_concom, detalle_concom,
accion_concom, tiporegla_concom, estatus_orduni,
created_date, created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'),
null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea,
'ERROR', 'MKT', 'RECHAZO - Diferentes gerentes de mkt en las lineas de la orden',
'RECHAZO', null, '10',
clock_timestamp(), 'ORDUNI2'
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d
where  e.id_solicitud = d.id_solicitud
and    e.id_solicitud = p_id_solicitud;
elsif v_resultado = 0 and nullif(v_gerentemkt::text, '') is null then
perform dbms_output.put_line('-->Se rechaza la orden!!!');
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom,
resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom,
estatus_concom, campo_concom, detalle_concom,
accion_concom, tiporegla_concom, estatus_orduni,
created_date, created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'),
null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea,
'ERROR', 'MKT', 'RECHAZO - No hay gerente de mkt para la orden',
'RECHAZO', null, '10',
clock_timestamp(), 'ORDUNI2'
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d
where  e.id_solicitud = d.id_solicitud
and    e.id_solicitud = p_id_solicitud;
end if;
end if;end;
$body$
language plpgsql
;
