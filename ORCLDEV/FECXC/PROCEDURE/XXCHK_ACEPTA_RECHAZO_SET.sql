create or replace procedure fecxc."xxchk_acepta_rechazo_set"  ( p_no_folio_det numeric, p_importe numeric, p_id_tipo_operacion_set numeric, p_moneda varchar, p_id_usuario numeric, p_usuario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ayuda integer;
v_sec_id_cheque integer;
v_e_codigo integer;
v_fec_valor_original timestamp(0);
v_fec_valor timestamp(0);
v_id_banco integer;
v_referencia_cliente varchar(250);
v_id_estado_cheque integer;
v_importe numeric(30,4);
v_moneda varchar(250);
v_customer_name varchar(250);
begin 

begin
select nextval('xxchk_sec_id_cheque'), a.e_codigo, a.fec_valor_original,
coalesce(a.fec_valor,clock_timestamp()), a.id_banco, a.referencia_cliente, b.id_estado_cheque, a.importe,
a.moneda
into strict   v_sec_id_cheque, v_e_codigo, v_fec_valor_original,
v_fec_valor, v_id_banco, v_referencia_cliente, v_id_estado_cheque, v_importe,
v_moneda
from xxchk_cheques_all a, xxchk_mapeo_de_estados b
where	nullif(procesado::text, '') is null
and a.no_folio_det = p_no_folio_det
and	a.id_tipo_operacion_set = b.id_tipo_operacion_set
and	chk_orden = p_id_usuario;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_SEC_ID_CHEQUE, V_E_CODIGO, V_FEC_VALOR_ORIGINAL,V_FEC_VALOR, V_ID_BANCO, V_REFERENCIA_CLIENTE, V_ID_ESTADO_CHEQUE, V_IMPORTE, V_MONEDA, V_NO_FOLIO_DET', to_char(v_sec_id_cheque), ' - ', to_char(v_e_codigo), ' - ', to_char(v_fec_valor_original), ' - ', to_char(v_fec_valor), ' - ', to_char(v_id_banco), ' - ', to_char(v_referencia_cliente), ' - ', to_char(v_id_estado_cheque), ' - ', to_char(v_importe), ' - ', to_char(v_moneda), ' - ', to_char(p_no_folio_det))) ;/* dmap converted statement end */
exception
when no_data_found then
--		   		 dbms_output.put_line('NO HAY DATOS');
raise exception '%', 'No ha seleccionado registros' using errcode = '45000';
when others then
--		   		dbms_output.put_line('Error desconocido');
raise exception '%', 'Unknown errors' using errcode = '45000';
end;
select customer_name
into strict v_customer_name
from xxchk_cheques_all  a,
ra_customers__erp_prod b
where a.no_folio_det = p_no_folio_det
and a.referencia_cliente = b.orig_system_reference;
begin
insert into xxchk_captura_cheques(id_sec_cheque, created_by, date_created, e_codigo, entregado_por, fecha_cobro,
fecha_emision, id_banco, id_cliente, id_estado_cheque, importe, last_modified_date,
modified_by, moneda, no_cheque, referencia_cliente,expide,imagen,desc_cliente)
values ( v_sec_id_cheque,p_usuario, clock_timestamp(), v_e_codigo, 'SISTEMA', v_fec_valor_original,
v_fec_valor, v_id_banco, v_referencia_cliente, v_id_estado_cheque, v_importe, clock_timestamp(),
'', v_moneda, p_no_folio_det, v_referencia_cliente,'EXTRAIDO_SET','SIN IMAGEN',v_customer_name);
update xxchk_cheques_all set procesado = 1
where nullif(procesado::text, '') is null
and   no_folio_det = p_no_folio_det
and	  chk_orden = p_id_usuario;
exception
when no_data_found then
raise exception '%', 'No selecciono ningun registro.' using errcode = '45000';
end;
begin
call fecxc.xxchk_envia_chks_manual (v_sec_id_cheque, 'SISTEMA', 80 );
end;end;
$body$
language plpgsql
;
