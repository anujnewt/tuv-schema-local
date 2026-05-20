create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_marcas_orden ( p_id_solicitud integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_marcas          varchar(1000);
v_output          varchar(1000);
v_advid           varchar(50);
v_count_marcas    integer := 0;
v_correo_factur   integer := 0;
v_id_fza_ventas   integer;
v_esq_factur      varchar(20);
lineas_ord_cur cursor for
select distinct marca
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select id_fza_ventas
into strict v_id_fza_ventas
from xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud;/* dmap converted statement start */
select  concat('''''', esquema_factur, ''''''
) into strict v_esq_factur
from xxmor_fzas_vtas_tab
where id_fza_ventas = v_id_fza_ventas;/* dmap converted statement end *//* dmap converted statement start */
begin
select  concat('''''''', advid, ''''''''
) into strict v_advid
from xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud;/* dmap converted statement end */
exception
when others then
return 'NO SE ENCONTRO SOLICITUD';
end;
begin
select count(1)
into strict   v_correo_factur
from   xxmor_conf_notific_tab
where  usuario_factur = 1
and    id_seg_neg     = 1
and    id_fza_ventas  = v_id_fza_ventas;
exception
when others then
return 'NO SE ECNONTRO FZA';
end;
v_marcas := '''';/* dmap converted statement start */
for marcas in lineas_ord_cur loop
v_marcas :=  concat(v_marcas, '''''', marcas.marca, ''''',') ;/* dmap converted statement end */
v_count_marcas := v_count_marcas + 1;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_MARCAS: ', v_marcas)) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
v_marcas := oracle. concat(substr(v_marcas,1,length(v_marcas) - 1), '''') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_MARCAS: ', v_marcas)) ;/* dmap converted statement end *//* dmap converted statement start */
if v_count_marcas > 0 and v_correo_factur > 0 then
v_output :=  concat('CALL MOR.XXMOR_MAILS_FACTUR_PR(', p_id_solicitud , ',', v_advid, ',', v_marcas, ',', v_esq_factur, ')') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_MARCAS: ', v_marcas)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('4 V_OUTPUT: ', v_output)) ;/* dmap converted statement end */
return coalesce(v_output,'select '' '' as hola from sysibm.sysdummy1');end;
$body$
language plpgsql
;
