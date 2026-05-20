create or replace procedure feci."histfeci_procesa_recibos_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador_recibos numeric;
begin
contador_recibos:=0;
select
count(folio_recibo) into strict contador_recibos
from histfeci_recibos_masivo_tab
where
folio_recibo not in (select folio_recibo from feci_recibo_tab);
if contador_recibos > 0 then
-- registra recibos en feci_recibo_tab
insert into feci_recibo_tab(
folio_recibo,
fec_ingreso,
fec_deposito,
fec_contabilidad,
fec_operativa,
importe,
cod_moneda,
cod_empresa,
cod_cliente,
nom_cliente,
ref_cliente,
clase_cliente,
metodo_pago,
nom_banco_emisor,
num_chequera,
num_cheque,
num_operacion,
tipo_cambio_origen,
fec_tc_origen,
tipo_cambio_dolar,
fec_tc_dolar,
id_usuario_clasificacion,
fec_clasificacion,
id_usuario_aplicacion,
fec_aplicacion,
cod_estado_recibo,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
)
select
max(folio_recibo) as folio_recibo,
max(fec_ingreso) as fec_ingreso,
max(fec_deposito) as fec_deposito,
max(fec_contabilidad) as fec_contabilidad,
max(fec_contabilidad) as fec_operativa,
max(importe) as importe,
max(cod_moneda) as cod_moneda,
max(cod_empresa) as cod_empresa,
max(cod_cliente) as cod_cliente,
max(nom_cliente) as nom_cliente,
max(ref_cliente) as ref_cliente,
max(cod_clase_cliente) as clase_cliente,
max(metodo_pago) as metodo_pago,
max(nom_banco_emisor) as nom_banco_emisor,
max(num_chequera) as num_chequera,
max(num_cheque) as num_cheque,
max(num_operacion) as num_operacion,
max(tipo_cambio_origen) as tipo_cambio_origen,
max(fec_tc_origen) as fec_tc_origen,
max(tipo_cambio_dolar) as tipo_cambio_dolar,
max(fec_tc_dolar) as fec_tc_dolar,
0 as id_usuario_clasificacion,
max(fec_clasificacion) as fec_clasificacion,
0 as id_usuario_aplicacion,
max(fec_aplicacion) as fec_aplicacion,
'APLC' as cod_estado_recibo,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from histfeci_recibos_masivo_tab
where
folio_recibo not in (select folio_recibo from feci_recibo_tab)
group by
folio_recibo;
end if;end;
$body$
language plpgsql
;
