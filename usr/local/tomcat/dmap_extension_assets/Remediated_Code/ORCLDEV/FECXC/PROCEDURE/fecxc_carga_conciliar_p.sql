create or replace procedure fecxc."fecxc_carga_conciliar_p"  ( p_anio numeric, p_mes numeric, p_dni numeric default 0, p_otros numeric default 0, p_formato numeric default 1, p_usuario varchar  default null) as $body$
declare
-- pgv moved types start
-- pgv moved types end
countreg   numeric;
monedaloc  varchar(40);
begin 

begin
select desmoneda into strict monedaloc from fecxc_monedas  where es_moneda_loccal = 1;
RAISE NOTICE '%', monedaloc;
end;
/****************************************************************************
limpia todos los datos creados con el usuario que invoco el proc
****************************************************************************/
delete from fecxc_conciliacion_rep where  usuario = p_usuario;
/****************************************************************************
carga cobranza nominal (depositos)
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
1 as secuencia ,
'Cobranza Nominal' as titulo ,
null ,
coalesce(sum(b.importe), 0),
null ,
coalesce(sum(b.importe), 0),
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
and i.excluir_enreportes = 'NO'
and nullif(b.segmento1::text, '') is not null
group by c.mes_cobranza, c.anio_cobranza,m.desmoneda;
/****************************************************************************
carga iva
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
2 as secuencia,
'IVA' as titulocxc,
coalesce(sum(b.importe), 0) as titulo,
null,
coalesce(sum(b.importe), 0) as totalizqfe,
null,
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and tipo_linea = 'IMPUESTO'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
carga iva  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de iva
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
2 as secuencia,
'IVA' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 2
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
carga traspasos
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select   p_usuario,
3 as secuencia,
'Traspasos' as titulo,
coalesce(sum(b.importe), 0) ,
null ,
coalesce(sum(b.importe), 0) ,
null ,
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 1
and tipo_linea = 'TRASPASOS'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
carga traspasos  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de traspasos
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
3 as secuencia,
'Traspasos' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 10
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
carga reclasificaciones
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select   p_usuario,
4 as secuencia,
'Reclasificaciones' as titulo,
coalesce(sum(b.importe), 0),
null,
coalesce(sum(b.importe), 0),
null,
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 1
and tipo_linea = 'RECLASIFICACIONES'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
carga reclasificaciones  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de reclasificaciones
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
4 as secuencia,
'Reclasificaciones' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 5
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
carga movimientos extraordinarios
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select   p_usuario,
5 as secuencia,
'Movimientos extraordinarios' as titulo,
coalesce(sum(b.importe), 0),
null,
coalesce(sum(b.importe), 0),
null,
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_calendario_cob d,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.f_deposito != a.f_real_dep
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and i.nopara_flujo = 1
and tipo_linea = 'BASE'
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and a.f_real_dep >= d.fecha_inicio
and a.f_real_dep <= d.fecha_fin
and c.mes_cobranza != d.mes_cobranza
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
carga movimientos extraordinarios  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de movimientos extraordinarios
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
5 as secuencia,
'Movimientos extraordinarios' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 6
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
totales
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
6 as secuencia,
'SUBTOTAL' as titulo,
null,
coalesce(totaldercxc,0),
null,
coalesce(totalderfe,0) ,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where usuario = p_usuario
and a.anno_rep = p_anio
and secuencia = 1;
/****************************************************************************
espacio en blaco
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
7 as secuencia,
'-' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 7
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
(-) empresas no gestionadas
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
8 as secuencia ,
'(-) Empresa no gestionada' as titulo ,
null,
null,
null,
-1 * coalesce(sum(b.importe), 0),
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
k.desc_valor
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i,
fecxc_resta_segmentos j,
fecxc_det_catalogos k
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and tipo_linea = 'BASE'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
and j.cod_sec_lin = b.segmento1
and j.cod_sec_tipcat = 1
and b.segmento1 = k.cod_sec_lin
and k.tipo_cat = 'SEGMENTO'
group by c.mes_cobranza, c.anio_cobranza,m.desmoneda,k.desc_valor;
/****************************************************************************
verifica si el insert anterior genero regisros para insertar o no una linea
****************************************************************************/
countreg := 0;
begin
select count(secuencia) into strict countreg
from fecxc_conciliacion_rep
where   secuencia = 8
and usuario = p_usuario;
exception
when no_data_found then
countreg := 0;
end;
RAISE NOTICE '%', countreg;
if countreg > 0 then
/****************************************************************************
totales empresas no gestionadas
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
9 as secuencia,
'-' as titulo,
null,
null,
null,
coalesce(sum(totalderfe),0) ,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where usuario = p_usuario
and a.anno_rep = p_anio
and secuencia = 8
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
espacio en blaco
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
10 as secuencia,
'*' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 10
)
group by a.mes_rep, a.anno_rep,a.moneda;
end if;
/****************************************************************************
carga cobranza virtual
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
11 as secuencia,
'Cobranza Virtual' as titulo,
coalesce(sum(b.importe), 0) ,
null,
null,
-1 * coalesce(sum(b.importe), 0),
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 1
and tipo_linea = 'COBVIRTUAL'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
carga cobranza virtual  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de cobranza virtual
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
11 as secuencia,
'Cobranza Virtual' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 11
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
carga otros ingresos
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
12 as secuencia,
'Otros conceptos' as titulo,
null,
null,
null,
case when m.es_moneda_loccal = 1 then (coalesce(sum(b.importe), 0) + p_otros ) else coalesce(sum(b.importe), 0)  end as totalderfe,
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 2
and tipo_linea = 'OTROS'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by m.es_moneda_loccal,c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
carga intereses  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de intereses
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
12 as secuencia,
'Otros conceptos' as titulo,
null,
null,
null,
case when a.moneda = 'MONEDA NACIONAL' then
p_otros  else null end ,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 12
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
carga intercambios
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
13 as secuencia,
'Intercambios' as titulo,
null,
null,
null,
coalesce(sum(b.importe), 0) as totalderfe,
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 2
and tipo_linea = 'INTERCAMBIOS'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
carga intercambios  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de intercambios
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
13 as secuencia,
'Intercambios' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 13
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
carga intereses
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
14 as secuencia,
'Intereses' as titulo,
null,
null,
null,
coalesce(sum(b.importe), 0) as totalderfe,
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 2
and tipo_linea = 'INTERESES'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
carga intereses  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de intereses
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
14 as secuencia,
'Intereses' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 14
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
carga dni
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
15 as secuencia,
'DNI' as titulo,
null,
null,
null,
case when m.es_moneda_loccal = 1 then (coalesce(sum(b.importe), 0) + p_dni ) else coalesce(sum(b.importe), 0)  end as totalderfe,
case c.mes_cobranza
when 1  then 'Enero'
when 2  then 'Febrero'
when 3  then 'Marzo'
when 4  then 'Abril'
when 5  then 'Mayo'
when 6  then 'Junio'
when 7  then 'Julio'
when 8  then 'Agosto'
when 9  then 'Septiembre'
when 10 then 'Octubre'
when 11 then 'Noviembre'
when 12 then 'Diciembre'
end as mes,
c.anio_cobranza,
m.desmoneda,
''
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 2
and tipo_linea = 'DNI'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza = p_anio
group by m.es_moneda_loccal,c.mes_cobranza, c.anio_cobranza,  m.desmoneda;
/****************************************************************************
carga dni  (inserta en cero todos los valores para las monedas
que no se incluyeron en el proceso de dni
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
15 as secuencia,
'DNI' as titulo,
null,
null,
null,
case when a.moneda = 'MONEDA NACIONAL' then
p_dni  else null end ,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 15
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
totales
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
16 as secuencia,
'TOTAL' as titulo,
null,
coalesce(sum(totaldercxc),0) ,
null,
coalesce(sum(totalderfe),0) ,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where usuario = p_usuario
and a.anno_rep = p_anio
and secuencia in (6,9,11,12,13,14,15)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
espacio en blaco
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
17 as secuencia,
'#' as titulo,
null,
null,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where a.moneda not in (
select  x.moneda
from fecxc_conciliacion_rep x
where x.usuario = p_usuario
and x.anno_rep = p_anio
and x.secuencia = 17
)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************************************************************
diferencia
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
18 as secuencia,
'Diferencia' as titulo,
null,
coalesce(totaldercxc-totalderfe,0),
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where usuario = p_usuario
and a.anno_rep = p_anio
and secuencia = 16;
/****************************************************************************
comprobacion
****************************************************************************/
insert into fecxc_conciliacion_rep(
usuario,
secuencia,
titulo,
totalizqcxc,
totaldercxc,
totalizqfe,
totalderfe,
mes_rep,
anno_rep,
moneda,
segrestar
)
select
p_usuario,
19 as secuencia,
'Comprobacion' as titulo,
null,
coalesce(sum(totaldercxc)+sum(totalderfe),0) ,
null,
null,
a.mes_rep,
a.anno_rep,
a.moneda,
''
from fecxc_conciliacion_rep a
where usuario = p_usuario
and a.anno_rep = p_anio
and secuencia in (9,11,12,13,14,15,18)
group by a.mes_rep, a.anno_rep,a.moneda;
/****************************   sin ordernar   ******************************/
/****************************************************************************
aplica formato
****************************************************************************/
update  fecxc_conciliacion_rep set
totalizqcxc = totalizqcxc / p_formato,
totaldercxc = totaldercxc / p_formato,
totalizqfe  = totalizqfe / p_formato,
totalderfe  = totalderfe /p_formato
where usuario = p_usuario
and anno_rep = p_anio;
/****************************************************************************
fin
****************************************************************************/
end;
$body$
language plpgsql
;
