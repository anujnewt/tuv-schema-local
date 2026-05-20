create or replace procedure fecxc."feci_modifica_tipo_cambio_recibo_pr"  ( p_recibo numeric, p_tipo varchar, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
moneda varchar(50);
fecha_operativa timestamp(0);
cambio_origen numeric;
cambio_dolar numeric;
fecha_tc_dolar timestamp(0);
fecha_tc_origen timestamp(0);
contador numeric;
begin 

select cod_moneda into strict moneda
from feci_recibos_vw
where folio_recibo = p_recibo and tipo_recibo = p_tipo;
--dbms_output.put_line('MONEDA: ' || moneda);
select fec_operativa into strict fecha_operativa
from feci_recibos_vw
where folio_recibo = p_recibo and tipo_recibo = p_tipo;
--dbms_output.put_line('FECHA_OPERATIVA: ' || fecha_operativa);
if ( moneda='MXN') then
select  count(*) into strict  contador
from feci_tipo_cambio_cat
where (fec_fecha_tc =  fecha_operativa   and cod_moneda = 'USD');
if (contador > 0 ) then
select num_valor, fec_fecha_tc into strict cambio_dolar, fecha_tc_dolar
from feci_tipo_cambio_cat
where (fec_fecha_tc =  fecha_operativa  and cod_moneda = 'USD');
else
select num_valor, fec_fecha_tc into strict cambio_dolar, fecha_tc_dolar
from feci_tipo_cambio_cat
where (cod_moneda = 'USD' and fec_fecha_tc = (
select max(fec_fecha_tc)
from feci_tipo_cambio_cat
where cod_moneda = 'USD'));
end if;
if (p_tipo = 'BATCH'  )then
update feci_recibo_tab set
tipo_cambio_origen = 1,
fec_tc_origen = fecha_operativa ,
tipo_cambio_dolar = cambio_dolar,
fec_tc_dolar =  fecha_tc_dolar
where folio_recibo =  p_recibo;
else
---esta seccion es para los recibos manuales
update feci_recibo_manual_tab set
tipo_cambio_origen = 1,
fec_tc_origen = fecha_operativa,
tipo_cambio_dolar = cambio_dolar,
fec_tc_dolar =fecha_tc_dolar
where folio_recibo_manual =  p_recibo;
end if;
else
----select para traer los datos de moneda origen
select  count(*) into strict  contador
from feci_tipo_cambio_cat
where (fec_fecha_tc = fecha_operativa  and cod_moneda = moneda);
if (contador > 0 ) then
select num_valor, fec_fecha_tc into strict cambio_origen, fecha_tc_origen
from feci_tipo_cambio_cat
where (fec_fecha_tc =  fecha_operativa   and cod_moneda = moneda);
else
select num_valor, fec_fecha_tc into strict cambio_origen, fecha_tc_origen
from feci_tipo_cambio_cat
where (cod_moneda = moneda and fec_fecha_tc = (
select max(fec_fecha_tc)
from feci_tipo_cambio_cat
where cod_moneda = moneda));
end if;
---select para traer los datos moneda usd (dolar)
select  count(*) into strict  contador
from feci_tipo_cambio_cat
where (fec_fecha_tc = fecha_operativa  and cod_moneda = 'USD');
if (contador > 0 ) then
select num_valor, fec_fecha_tc into strict cambio_dolar, fecha_tc_dolar
from feci_tipo_cambio_cat
where (fec_fecha_tc =  fecha_operativa  and cod_moneda = 'USD');
else
select num_valor, fec_fecha_tc into strict cambio_dolar, fecha_tc_dolar
from feci_tipo_cambio_cat
where (cod_moneda = 'USD' and fec_fecha_tc = (
select max(fec_fecha_tc)
from feci_tipo_cambio_cat
where cod_moneda = 'USD'));
end if;
if (p_tipo = 'BATCH'  )then
update feci_recibo_tab set
tipo_cambio_origen = cambio_origen,
fec_tc_origen = fecha_tc_origen,
tipo_cambio_dolar = cambio_dolar,
fec_tc_dolar = fecha_tc_dolar
where folio_recibo =  p_recibo;
else
---esta seccion es para los recibos manuales
update feci_recibo_manual_tab set
tipo_cambio_origen = cambio_origen,
fec_tc_origen = fecha_tc_origen,
tipo_cambio_dolar = cambio_dolar,
fec_tc_dolar = fecha_tc_dolar
where folio_recibo_manual =  p_recibo;
end if;
end if;end;
$body$
language plpgsql
;
