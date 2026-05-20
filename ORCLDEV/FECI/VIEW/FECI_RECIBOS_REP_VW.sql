-- dmap_object_gen_tag : type : view name : feci_recibos_rep_vw
set search_path = feci,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "feci_recibos_rep_vw"  ("folio_recibo", "tipo_recibo", "fec_contabilidad", "fec_operativa", "fec_deposito", "importe", "cod_moneda", "des_moneda", "cod_empresa", "des_empresa", "cod_cliente", "ref_cliente", "nom_cliente", "clase_cliente", "metodo_pago", "nom_banco_emisor", "num_chequera", "num_cheque", "num_operacion", "tipo_cambio_origen", "fec_tc_origen", "tipo_cambio_dolar", "fec_tc_dolar", "id_usuario_clasificacion", "fec_clasificacion", "id_usuario_aplicacion", "fec_aplicacion", "cod_estado_recibo", "fec_creacion", "fec_ult_modificacion", "id_usuario_creacion", "id_usuario_ult_modif", "ind_estado") as select
to_char(rec.folio_recibo_manual)   as folio_recibo
, 'MANUAL'                 as tipo_recibo
, rec.fec_contabilidad     as fec_contabilidad
, rec.fec_operativa        as fec_operativa
, rec.fec_operativa        as fec_deposito
, rec.importe              as importe
, rec.cod_moneda           as cod_moneda
, mon.des_moneda           as des_moneda
, rec.cod_empresa          as cod_empresa
, emp.des_empresa          as des_empresa
, rec.cod_cliente          as cod_cliente
, rec.ref_cliente          as ref_cliente
, rec.nom_cliente          as nom_cliente
, rec.clase_cliente        as clase_cliente
, rec.metodo_pago          as metodo_pago
, rec.nom_banco_emisor     as nom_banco_emisor
, rec.num_chequera         as num_chequera
, rec.num_cheque           as num_cheque
, rec.num_operacion        as num_operacion
, rec.tipo_cambio_origen   as tipo_cambio_origen
, rec.fec_tc_origen        as fec_tc_origen
, rec.tipo_cambio_dolar    as tipo_cambio_dolar
, rec.fec_tc_dolar         as fec_tc_dolar
, rec.id_usuario_clasificacion  as id_usuario_clasificacion
, rec.fec_clasificacion	  as fec_clasificacion
, rec.id_usuario_aplicacion     as id_usuario_aplicacion
, rec.fec_aplicacion       as fec_aplicacion
, rec.cod_estado_recibo    as cod_estado_recibo
, rec.fec_creacion         as fec_creacion
, rec.fec_ult_modificacion as fec_ult_modificacion
, rec.id_usuario_creacion  as id_usuario_creacion
, rec.id_usuario_ult_modif as id_usuario_ult_modif
, rec.ind_estado           as "ind_estado"
from feci_recibo_manual_tab rec
inner join feci_moneda_cat mon on rec.cod_moneda = mon.cod_moneda
inner join feci_empresa_cat emp on rec.cod_empresa = emp.cod_empresa
--where rec.ind_estado = 1 and mon.ind_estado = 1 and emp.ind_estado = 1
union
select
to_char(rec.folio_recibo)   as folio_recibo
,'BATCH'                  as tipo_recibo
,rec.fec_contabilidad     as fec_contabilidad
,rec.fec_operativa        as fec_operativa
,rec.fec_deposito        as fec_deposito
,rec.importe              as importe
,rec.cod_moneda           as cod_moneda
,mon.des_moneda           as des_moneda
,rec.cod_empresa          as cod_empresa
,emp.des_empresa          as des_empresa
,rec.cod_cliente          as cod_cliente
,rec.ref_cliente          as ref_cliente
,rec.nom_cliente          as nom_cliente
,rec.clase_cliente        as clase_cliente
,rec.metodo_pago          as metodo_pago
,rec.nom_banco_emisor     as nom_banco_emisor
,rec.num_chequera         as num_chequera
,rec.num_cheque           as num_cheque
,rec.num_operacion        as num_operacion
,rec.tipo_cambio_origen   as tipo_cambio_origen
,rec.fec_tc_origen        as fec_tc_origen
,rec.tipo_cambio_dolar    as tipo_cambio_dolar
,rec.fec_tc_dolar         as fec_tc_dolar
,rec.id_usuario_clasificacion  as id_usuario_clasificacion
,rec.fec_clasificacion	  as fec_clasificacion
,rec.id_usuario_aplicacion     as id_usuario_aplicacion
,rec.fec_aplicacion       as fec_aplicacion
,rec.cod_estado_recibo    as cod_estado_recibo
,rec.fec_creacion         as fec_creacion
,rec.fec_ult_modificacion as fec_ult_modificacion
,rec.id_usuario_creacion  as id_usuario_creacion
,rec.id_usuario_ult_modif as id_usuario_ult_modif
,rec.ind_estado           as "ind_estado"
from feci_recibo_tab rec
inner join feci_moneda_cat mon on rec.cod_moneda = mon.cod_moneda
inner join feci_empresa_cat emp on rec.cod_empresa = emp.cod_empresa
where rec.ind_estado = 1 --and mon.ind_estado = 1 and emp.ind_estado = 1
;/* dmap converted statement end */
-- estimed cost of view [ feci_recibos_rep_vw ]: 1.20;
