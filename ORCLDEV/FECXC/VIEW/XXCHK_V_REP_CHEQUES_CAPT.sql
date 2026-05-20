-- dmap_object_gen_tag : type : view name : xxchk_v_rep_cheques_capt
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxchk_v_rep_cheques_capt"  ("estatus_cheque", "id_estado_cheque", "banco", "cliente", "referencia_cliente", "no_cheque", "no_cheque_reemplazo", "fecha_ultima_modificacion", "fecha_de_creacion", "importe", "moneda", "antiguedad_origen", "antiguedad_cambio_est", "sysdate_fecha_cobro", "cheques_a_depositar", "fecha_emision", "fecha_caputra", "fecha_cambio", "fecha_cobro", "esrechazo") as select distinct
ce.descripcion as estatus_cheque,
ce.id_estado_cheque,
cb.descripcion_banco as banco,
cc.desc_cliente as cliente,
cc.referencia_cliente,
cc.no_cheque,
cc.no_cheque_reemplazo,
to_char(cc.last_modified_date) as fecha_ultima_modificacion,
to_char(cc.date_created) as fecha_de_creacion,
cc.importe,
cc.moneda,
to_char(trunc(statement_timestamp()-cc.date_created, 0)) as antiguedad_origen,
to_char(trunc(statement_timestamp()-cc.last_modified_date, 0)) as antiguedad_cambio_est,
to_char(trunc(statement_timestamp()-cc.fecha_cobro, 0)) as sysdate_fecha_cobro,
to_char(trunc(statement_timestamp()-cc.fecha_emision, 0)) as cheques_a_depositar,
cc.fecha_emision,
cc.date_created as fecha_caputra,
cc.last_modified_date as fecha_cambio,
cc.fecha_cobro,
'NORMAL' as "esrechazo"
from xxchk_captura_cheques cc,
xxchk_catalogo_bancos cb,
xxchk_cat_edos ce
where cc.id_banco = cb.id_banco
and      ce.tipo_operacion = 'RECHAZADO'
and   cc.id_estado_cheque =ce.id_estado_cheque
union
select distinct
ce.descripcion as estatus_cheque,
ce.id_estado_cheque,
cb.descripcion_banco as banco,
cc.desc_cliente as cliente,
cc.referencia_cliente,
cc.no_cheque,
cc.no_cheque_reemplazo,
to_char(cc.last_modified_date) as fecha_ultima_modificacion,
to_char(cc.date_created) as fecha_de_creacion,
cc.importe,
cc.moneda,
to_char(trunc(statement_timestamp()-cc.date_created, 0)) as antiguedad_origen,
to_char(trunc(statement_timestamp()-cc.last_modified_date, 0)) as antiguedad_cambio_est,
to_char(trunc(statement_timestamp()-cc.fecha_cobro, 0)) as sysdate_fecha_cobro,
to_char(trunc(statement_timestamp()-cc.fecha_emision, 0)) as cheques_a_depositar,
cc.fecha_emision,
cc.date_created as fecha_caputra,
cc.last_modified_date as fecha_cambio,
cc.fecha_cobro,
'NORMAL' as "esrechazo"
from xxchk_captura_cheques cc,
xxchk_catalogo_bancos cb,
xxchk_cat_edos ce
where cc.id_banco = cb.id_banco
and      ce.tipo_operacion <> 'RECHAZADO'
and   cc.id_estado_cheque =ce.id_estado_cheque;/* dmap converted statement end */
-- estimed cost of view [ xxchk_v_rep_cheques_capt ]: 2.20;
