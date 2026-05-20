create or replace procedure feci."feci_procesa_batch_pr"  ( p_fecha_inicio timestamp(0), p_error varchar default null, p_tipo_ejecucion varchar  default null) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador_recibos numeric;
contador_empresa numeric;
contador_monedas numeric;
contador_tc numeric;
tipo_resultado_ varchar(32767);
str_error varchar(32767);
begin
if nullif(p_error::text, '') is null then
begin
str_error := '-';
--elimina registros de feci_carga_recibos_batch donde cia='CIA'
delete from feci_carga_recibos_batch where cia = 'CIA';
select
count(distinct trim(both cia)) into strict contador_empresa
from feci_carga_recibos_batch
where nullif(trim(both from cia::text), '') is not null
and trim(both cia) not in (select trim(both cod_empresa) from feci_empresa_cat);
if contador_empresa > 0 then
-- registra empresas que no est?en el cat?go feci_empresa_cat
insert into feci_empresa_cat(
cod_empresa,
des_empresa,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
)
select distinct
trim(both cia) as cod_empresa,
trim(both desc_cia) as des_empresa,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from feci_carga_recibos_batch
where nullif(trim(both from cia::text), '') is not null
and trim(both cia) not in (select trim(both cod_empresa) from feci_empresa_cat);
end if;
select
count( distinct trim(both currency_code))  into strict contador_monedas
from feci_carga_recibos_batch
where nullif(trim(both from currency_code::text), '') is not null
and trim(both currency_code) not in (select trim(both cod_moneda) from feci_moneda_cat);
if contador_monedas > 0 then
-- registra monedas que no est?en el cat?go feci_moneda_cat
insert into feci_moneda_cat(
cod_moneda,
des_moneda,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
)
select distinct
trim(both currency_code) as moneda,
trim(both currency) as des_moneda,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from feci_carga_recibos_batch
where nullif(trim(both from currency_code::text), '') is not null
and trim(both currency_code) not in (select trim(both cod_moneda) from feci_moneda_cat);
end if;
select
count(folio_recibo) into strict contador_recibos
from feci_carga_recibos_batch
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
folio_recibo,
to_timestamp(receipt_date,'DD/MM/YYYY')  as fec_ingreso,
to_timestamp(deposit_date,'DD/MM/YYYY') as fec_deposito,
to_timestamp(fecha_gl,'DD/MM/YYYY') as fec_contabilidad,
to_timestamp(fecha_gl,'DD/MM/YYYY') as fec_operativa,
amount as importe,
currency_code as cod_moneda,
cia as cod_empresa,
numero_cliente as cod_cliente,
nombre_cliente as nom_cliente,
referencia_cliente as ref_cliente,
clase_cliente as clase_cliente,
receipt_method as metodo_pago,
bank_name as nom_banco_emisor,
bank_account_name as num_chequera,
num_cheque,
tipo_operacion as num_operacion,
null as tipo_cambio_origen,
null as fec_tc_origen,
null as tipo_cambio_dolar,
null as fec_tc_dolar,
null as id_usuario_clasificacion,
null as fec_clasificacion,
null as id_usuario_aplicacion,
null as fec_aplicacion,
'PEND' as cod_estado_recibo,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from feci_carga_recibos_batch
where
folio_recibo not in (select folio_recibo from feci_recibo_tab );
end if;
delete from feci_carga_recibos_batch;
---aqui se debe colocar lo de tipos de cambio para el contador
select
count(fecha) into strict contador_tc
from feci_carga_tipocambio_batch tcb
where not exists (
select 1
from feci_tc_moneda_cat tcm
where
tcm.fec_fecha_tc = to_timestamp(tcb.fecha,'DD/MM/YYYY')
and tcm.cod_mon_origen = tcb.de
and tcm.cod_mon_destino = tcb.a
);
if contador_tc > 0 then
insert into feci_tc_moneda_cat(
fec_fecha_tc,
cod_mon_origen,
cod_mon_destino,
num_tipo_cambio,
num_factor,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
)
select
to_timestamp(tcb.fecha,'DD/MM/YYYY') as fec_fecha_tc,
tcb.de as cod_mon_origen,
tcb.a as cod_mon_destino,
tcb.tipo_cambio as num_tipo_cambio,
tcb.factor as num_factor,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from feci_carga_tipocambio_batch tcb
where not exists (
select 1
from feci_tc_moneda_cat tcm
where
tcm.fec_fecha_tc = to_timestamp(tcb.fecha,'DD/MM/YYYY')
and tcm.cod_mon_origen = tcb.de
and tcm.cod_mon_destino = tcb.a
);
-----------------registro de tipo de cambio
insert into feci_tipo_cambio_cat(
fec_fecha_tc,
cod_moneda,
num_valor,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
)
select distinct
to_timestamp(tcb.fecha,'DD/MM/YYYY') as fec_fecha_tc,
tcb.de as cod_mon_origen,
tcb.tipo_cambio as num_tipo_cambio,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from feci_carga_tipocambio_batch tcb
where not exists (
select 1
from feci_tipo_cambio_cat tcm
where
tcm.fec_fecha_tc = to_timestamp(tcb.fecha,'DD/MM/YYYY')
--and tcm.cod_moneda = 'MXN'
--or tcm.cod_moneda = 'USD'
--and tcm.cod_moneda = tcb.a
and tcm.cod_moneda = tcb.de
);
end if;
delete from feci_carga_tipocambio_batch;
------------------
call feci_modifica_tipo_cambio_recibo_masivo_pr (0);
tipo_resultado_ := 'EXITO';
exception
-- captura y maneja las excepciones
when others then
str_error := sqlerrm;
contador_recibos := 0;
contador_empresa := 0;
contador_monedas := 0;
contador_tc := 0;
tipo_resultado_ := 'ERROR';
-- realiza rollback en caso de error para deshacer los cambios
rollback;
end;
else
contador_recibos := 0;
contador_empresa := 0;
contador_monedas := 0;
contador_tc := 0;
tipo_resultado_ := 'ERROR';
str_error := p_error;
end if;
insert into feci_resultado_batch_tab(fec_inicio,fec_fin,tipo_ejecucion,num_nuevos_recibos,num_nuevas_empresas,num_nuevas_monedas,num_nuevos_tc,tipo_resultado,observaciones,
fec_creacion,fec_ult_modificacion,id_usuario_creacion,id_usuario_ult_modif,ind_estado)
values (p_fecha_inicio,clock_timestamp(),p_tipo_ejecucion,contador_recibos,contador_empresa,contador_monedas,contador_tc,tipo_resultado_,str_error,
clock_timestamp(),clock_timestamp(),0,0,1);
-- actualiza feci_carga_recibos_batch
--se cambia a un delte feci_carga_recibos_batch
--- se debe llenar la tabla de feci_resultado_batch_tab
end;
$body$
language plpgsql
;
