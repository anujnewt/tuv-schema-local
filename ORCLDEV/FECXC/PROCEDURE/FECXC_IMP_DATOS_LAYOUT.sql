create or replace procedure fecxc."fecxc_imp_datos_layout"  ( v_id_sesion varchar, v_mes numeric, v_per numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_errores integer:= 0;
mes_act varchar(2);
per_act varchar(4);
per_sig	integer;
fecha timestamp(0);
v_anios integer;
begin 

/* inicializa cifras de control*/
delete from fecxc_cifras_control
where mes = v_mes
and periodo = v_per;
-- ***** debugueo *****
update	fecxc_carga_presup
set		estatus_origen = 'VALIDO'
where (to_char(fecha,'MM'))::numeric  = v_mes
and anio = v_per;
--- **** valida el mes y periodo actuual
select clock_timestamp()
into strict fecha;
select to_char(clock_timestamp(),'MM')
into strict mes_act;
select to_char(clock_timestamp(),'YYYY')
into strict per_act;/* dmap converted statement start */
if (mes_act)::numeric  <> v_mes then
insert	into fecxp_bitacora_errores(id_sesion,mensaje)
values (v_id_sesion, concat('MES INVALIDO ', v_mes , 'MES ACTUAL ' , mes_act)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if (per_act)::numeric  <> v_per then
insert	into fecxp_bitacora_errores(id_sesion,mensaje)
values (v_id_sesion, concat('PERIODO INVALIDO ', v_per , 'PERIODO ACTUAL ' , mes_act)) ;/* dmap converted statement end */
end if;
--verifica si es periodo nuevo, si es asi, inserta codigo de monedas  22 y 14
per_sig := v_per + 1;
if (mes_act)::numeric  = 12 then
select	count(*)
into strict	v_anios
from	fecxc_enc_de_presu
where codanno = per_sig;/* dmap converted statement start */
if  v_anios = 0 then
insert into fecxc_enc_de_presu(sec_presup, secmoneda, codanno,fecha, usu_pres)
select nextval('sec_presup'), 22, per_sig, fecha,  concat('Carga Presupuesto ', per_act) ;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxc_enc_de_presu(sec_presup, secmoneda, codanno,fecha, usu_pres)
select nextval('sec_presup'), 14, per_sig, fecha,  concat('Carga Presupuesto ', per_act) ;/* dmap converted statement end */
end if;
end if;
-- ***** valida moneda *****
update	fecxc_carga_presup d
set		estatus_origen = 'MONEDA INVALIDA'
where moneda not in (
select  codmoneda
from fecxc_monedas
)
and	(to_char(d.fecha,'MM'))::numeric  = v_mes
and d.anio = v_per;
/*valida mes del archivo con el mes de generacion*/
update	fecxc_carga_presup d
set		estatus_origen = 'MES INVALIDO'
where	(to_char(d.fecha,'MM'))::numeric  <> v_mes
and d.anio = v_per;
/*valida periodo del archivo con el periodo de generacion*/
update	fecxc_carga_presup d
set		estatus_origen = 'PERIODO INVALIDO '
where	(to_char(d.fecha,'MM'))::numeric  = v_mes
and d.anio <> v_per;
-- ***** valida montos negativos *****
update	fecxc_carga_presup d
set		estatus_origen = 'MONTO NEGATIVO'
where importe < 0
and	(to_char(d.fecha,'MM'))::numeric  = v_mes
and d.anio = v_per;
-- ***** valida division *****
update fecxc_carga_presup d
set estatus_origen = 'DIVISION INVALIDA'
where division not in (
select  cod_valor
from fecxc_det_catalogos
where tipo_cat in ('REGION','DIVISION','CANAL')
)
and	(to_char(d.fecha,'MM'))::numeric  = v_mes
and d.anio = v_per;
-- ***** valida segmento *****
update fecxc_carga_presup d
set estatus_origen = 'SEGMENTO INVALIDO'
where segmento not in (
select cod_valor
from fecxc_det_catalogos
where tipo_cat in ('SEGMENTO')
)
and	(to_char(d.fecha,'MM'))::numeric  = v_mes
and d.anio = v_per;
-- ***** valida concepto *****
update fecxc_carga_presup d
set estatus_origen = 'CONCEPTO INVALIDO'
where concepto not in (
select  cod_valor
from fecxc_det_catalogos
where tipo_cat in ('CONCEPTO')
)
and	(to_char(d.fecha,'MM'))::numeric  = v_mes
and d.anio = v_per;/* dmap converted statement start */
-- ***** guarda bitacoras *****
-- *****  moneda invalida *****
insert	into fecxp_bitacora_errores(
id_sesion, mensaje)
select	v_id_sesion,  concat(estatus_origen, ': ' , moneda
) from	fecxc_carga_presup
where	estatus_origen = 'MONEDA INVALIDA'
and		(to_char(fecha,'MM'))::numeric  = v_mes
and 	anio = v_per
group by estatus_origen,moneda;/* dmap converted statement end *//* dmap converted statement start */
-- *****  mes invalido *****
insert	into fecxp_bitacora_errores(
id_sesion, mensaje)
select	v_id_sesion,  concat(estatus_origen, ': ' , to_char(fecha,'MM')
) from	fecxc_carga_presup
where	estatus_origen = 'MES INVALIDO'
and		(to_char(fecha,'MM'))::numeric  <> v_mes
and 	anio = v_per
group by estatus_origen,to_char(fecha,'MM');/* dmap converted statement end *//* dmap converted statement start */
-- *****  periodo invalido *****
insert	into fecxp_bitacora_errores(
id_sesion, mensaje)
select	v_id_sesion,  concat(estatus_origen, ': ' , 'A?O ORIGEN', to_char(anio)
) from	fecxc_carga_presup
where	estatus_origen = 'PERIODO INVALIDO'
and		(to_char(fecha,'MM'))::numeric  = v_mes
and 	anio <> v_per
group by estatus_origen,to_char(anio);/* dmap converted statement end *//* dmap converted statement start */
-- *****  monto  negativos*****
insert	into fecxp_bitacora_errores(
id_sesion, mensaje)
select	v_id_sesion,  concat(estatus_origen, ': ' , importe
) from	fecxc_carga_presup
where	estatus_origen = 'MONTO NEGATIVO'
and		(to_char(fecha,'MM'))::numeric  = v_mes
and 	anio = v_per
group by estatus_origen,importe;/* dmap converted statement end *//* dmap converted statement start */
-- *****  segmento invalido *****
insert	into fecxp_bitacora_errores(
id_sesion, mensaje)
select	v_id_sesion,  concat(estatus_origen, ': ' , segmento
) from	fecxc_carga_presup
where	estatus_origen = 'SEGMENTO INVALIDO'
and		(to_char(fecha,'MM'))::numeric  = v_mes
and 	anio = v_per
group by estatus_origen,segmento;/* dmap converted statement end *//* dmap converted statement start */
-- *****  concepto invalido *****
insert	into fecxp_bitacora_errores(
id_sesion, mensaje)
select	v_id_sesion,  concat(estatus_origen, ': ' , concepto
) from	fecxc_carga_presup
where	estatus_origen = 'CONCEPTO INVALIDO'
and		(to_char(fecha,'MM'))::numeric  = v_mes
and 	anio = v_per
group by estatus_origen,concepto;/* dmap converted statement end *//* dmap converted statement start */
-- *****  division invalida *****
insert	into fecxp_bitacora_errores(
id_sesion, mensaje)
select	v_id_sesion,  concat(estatus_origen, ': ' , division
) from	fecxc_carga_presup
where	estatus_origen = 'DIVISION INVALIDA'
and		(to_char(fecha,'MM'))::numeric  = v_mes
and 	anio = v_per
group by estatus_origen,division;/* dmap converted statement end *//* dmap converted statement start */
/**insrta registro duplicados */
insert	into fecxp_bitacora_errores(
id_sesion, mensaje)
select	v_id_sesion,  concat('REGISTRO DUPLICADO. CANTIDAD: ', cuantos , ',  FECHA: ' , to_char(clock_timestamp(), 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE=SPANISH') , ', SEGMENTO: ' , segmento , ', CONCEPTO: ' , concepto , ', ANIO: ' , to_char(anio) , ', DIVISION: ' , division
) from (
select count(1) cuantos, moneda,fecha,segmento,concepto,anio,division
from   fecxc_carga_presup
group by moneda,fecha,segmento,concepto,anio,division
) alias5
where	cuantos > 1;/* dmap converted statement end */
--****** valida que no exista comas en los importes ****
-- ***** procesa registros *****
select	count(*)
into strict	v_errores
from	fecxp_bitacora_errores;
if v_errores > 0 then
delete	from fecxc_carga_presup
where	(to_char(fecha,'MM'))::numeric  = v_mes
and 	anio = v_per;
else
--una vez que en el seis no hay inconsistencias se genera el archivo de cifras de control
--esto conlleva los siguientes sub-pasos por
--a..extraer cifras de control por segment0
--b..extraer cifras de control por concepto
--c..extraer cifras de control por division
--d..extraer cifras de control por canal
--e..extraer cifras de control por region
--a..extraer cifras de control por segment0
insert into fecxc_cifras_control(mes,periodo,segmento,importe_seg)
select v_mes,v_per,b.cod_valor, sum(importe)
from fecxc_carga_presup a, fecxc_det_catalogos b ,
fecxc_enc_de_presu e, fecxc_monedas f
where  b.tipo_cat = 'SEGMENTO'
and a.segmento = b.cod_valor
and a.anio = e.codanno
and a.moneda = f.codmoneda
and f.secmoneda = e.secmoneda
and (to_char(a.fecha,'MM'))::numeric  = v_mes
and a.anio = v_per
group by v_mes,v_per,b.cod_valor;
--b..extraer cifras de control por concepto
--delete fecxc_cifras_control
update fecxc_cifras_control set importe_con = (select sum(importe)
from fecxc_carga_presup a, fecxc_det_catalogos b ,fecxc_det_catalogos c,
fecxc_enc_de_presu e, fecxc_monedas f
where  b.tipo_cat = 'SEGMENTO'
and a.segmento = b.cod_valor
and c.tipo_cat = 'CONCEPTO'
and a.concepto = c.cod_valor
and a.anio = e.codanno
and a.moneda = f.codmoneda
and f.secmoneda = e.secmoneda
and fecxc_cifras_control.segmento = b.cod_valor
and (to_char(a.fecha,'MM'))::numeric  = v_mes
and a.anio = v_per
group by b.cod_valor );
--c..extraer cifras de control por division
update fecxc_cifras_control set importe_div	 = (select sum(importe)
from fecxc_carga_presup a, fecxc_det_catalogos b ,fecxc_det_catalogos c, fecxc_det_catalogos d,
fecxc_enc_de_presu e, fecxc_monedas f
where  b.tipo_cat = 'SEGMENTO'
and a.segmento = b.cod_valor
and c.tipo_cat = 'CONCEPTO'
and a.concepto = c.cod_valor
and d.tipo_cat = 'DIVISION'
and a.division = d.cod_valor
and a.anio = e.codanno
and a.moneda = f.codmoneda
and f.secmoneda = e.secmoneda
and fecxc_cifras_control.segmento = b.cod_valor
and (to_char(a.fecha,'MM'))::numeric  = v_mes
and a.anio = v_per
group by b.cod_valor);
--d..extraer cifras de control por canal
update fecxc_cifras_control set importe_can	 = (select sum(importe)
from fecxc_carga_presup a, fecxc_det_catalogos b ,fecxc_det_catalogos c, fecxc_det_catalogos d,
fecxc_enc_de_presu e, fecxc_monedas f
where  b.tipo_cat = 'SEGMENTO'
and a.segmento = b.cod_valor
and c.tipo_cat = 'CONCEPTO'
and a.concepto = c.cod_valor
and d.tipo_cat = 'CANAL'
and a.division = d.cod_valor
and a.anio = e.codanno
and a.moneda = f.codmoneda
and f.secmoneda = e.secmoneda
and fecxc_cifras_control.segmento = b.cod_valor
and (to_char(a.fecha,'MM'))::numeric  = v_mes
and a.anio = v_per
group by b.cod_valor);
--e..extraer cifras de control por region
update fecxc_cifras_control set importe_reg	 = (select sum(importe)
from fecxc_carga_presup a, fecxc_det_catalogos b ,fecxc_det_catalogos c, fecxc_det_catalogos d,
fecxc_enc_de_presu e, fecxc_monedas f
where  b.tipo_cat = 'SEGMENTO'
and a.segmento = b.cod_valor
and c.tipo_cat = 'CONCEPTO'
and a.concepto = c.cod_valor
and d.tipo_cat = 'REGION'
and a.division = d.cod_valor
and a.anio = e.codanno
and a.moneda = f.codmoneda
and f.secmoneda = e.secmoneda
and fecxc_cifras_control.segmento = b.cod_valor
and (to_char(a.fecha,'MM'))::numeric  = v_mes
and a.anio = v_per
group by b.cod_valor);
/*actualiza conceptos*/
update fecxc_cifras_control set concepto = segmento
where nullif(importe_con::text, '') is not null;
update fecxc_cifras_control set division = segmento
where nullif(importe_div::text, '') is not null;
update fecxc_cifras_control set canal = segmento
where nullif(importe_can::text, '') is not null;
update fecxc_cifras_control set region = segmento
where nullif(importe_reg::text, '') is not null;
-- ***** realiza cifras de control antes de incluir a historicos *****
insert	into	fecxp_bitacora_errores(id_sesion, mensaje)
values (v_id_sesion, 'CIFRAS DE CONTROL GENERADAS');
end if;end;
$body$
language plpgsql
;
