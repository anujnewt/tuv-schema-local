create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_get_mails_factur_fun ( p_id_solicitud integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_esquema_factur        varchar(20);
v_id_fza_ventas         integer;
v_mails                 varchar(300);
mails_fac_cur cursor for
select distinct trim(both vda.email) email
from   factur.vendedora_vtas__ordunidb2 vda
left join factur.control_vtas__ordunidb2 ct on vda.id_vd = ct.id_vd
where  trim(both ct.advid)     =  (select trim(both advid)
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
) -- cliente de la orden
and    trim(both ct.accthdrid) in (select distinct trim(both marca)
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
); -- marcas de las lineas;
mails_fac4_cur cursor for
select distinct trim(both vda.email) email
from   factur4.vendedora_vtas__ordunidb2 vda
left join factur4.control_vtas__ordunidb2 ct on vda.id_vd = ct.id_vd
where  trim(both ct.advid)     =  (select trim(both advid)
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
) -- cliente de la orden
and    trim(both ct.accthdrid) in (select distinct trim(both marca)
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
); -- marcas de las lineas;
mails_tvp_cur cursor for
select distinct trim(both vda.email) email
from   facturtvp.vendedora_vtas__ordunidb2 vda
left join facturtvp.control_vtas__ordunidb2 ct on vda.id_vd = ct.id_vd
where  trim(both ct.advid)     =  (select trim(both advid)
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
) -- cliente de la orden
and    trim(both ct.accthdrid) in (select distinct trim(both marca)
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
); -- marcas de las lineas;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
v_esquema_factur := null;
v_id_fza_ventas  := null;
v_mails          := null;
select id_fza_ventas
into strict   v_id_fza_ventas
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud;
select esquema_factur
into strict   v_esquema_factur
from   xxmor_fzas_vtas_tab
where  id_fza_ventas = v_id_fza_ventas;/* dmap converted statement start */
if v_esquema_factur = 'FACTUR' then
for correo_c in mails_fac_cur loop
v_mails :=  concat(v_mails, correo_c.email, ', ') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('FAC CORREO_C.EMAIL: ', correo_c.email)) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
elsif v_esquema_factur = 'FACTUR4' then
for correo_c in mails_fac4_cur loop
v_mails :=  concat(v_mails, correo_c.email, ', ') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('FAC4 CORREO_C.EMAIL: ', correo_c.email)) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
elsif v_esquema_factur = 'FACTURTVP' then
for correo_c in mails_tvp_cur loop
v_mails :=  concat(v_mails, trim(both correo_c.email), ', ') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('TVP CORREO_C.EMAIL: ', correo_c.email)) ;/* dmap converted statement end */
end loop;
end if;
if length(v_mails) > 5 then
select oracle.substr(v_mails, 0, length(v_mails) -2)
into strict v_mails
;
end if;
return v_mails;end;
$body$
language plpgsql
;
