create or replace procedure fecxc."fecxc_carga_conciliar_det_p"  ( p_anio numeric, p_mes numeric, p_dni numeric default 0, p_otros numeric default 0, p_usuario varchar  default null) as $body$
declare
-- pgv moved types start
-- pgv moved types end
countreg   numeric;
monedaloc  varchar(40);
empresaloc varchar(60);
begin 

begin
select desmoneda into strict monedaloc from fecxc_monedas  where es_moneda_loccal = 1;
perform dbms_output.put_line(monedaloc);
end;
begin
select des_empresa into strict empresaloc from fecxc_empresas  where e_codigo = 552;
perform dbms_output.put_line(empresaloc);
end;
/****************************************************************************
limpia todos los datos creados con el usuario que invoco el proc
****************************************************************************/
delete from fecxc_conciliacion_det_rep where  usuario = p_usuario;
/****************************************************************************
carga traspasos
****************************************************************************/
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
select p_usuario,
d.des_empresa,
m.desmoneda,
a.refecliente,
sum(b.importe) as importe,
a.codfolio,
'Traspasos' as tipo,
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
c.anio_cobranza
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_empresas d,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo =d.e_codigo
and b.cod_sec_det = i.cod_sec_det
and a.e_codigo =b.e_codigo
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 1
and tipo_linea = 'TRASPASOS'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza =p_anio
group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
carga reclasificaciones
****************************************************************************/
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
select p_usuario,
d.des_empresa,
m.desmoneda,
a.refecliente,
sum(b.importe) as importe,
a.codfolio,
'Reclasificaciones' as tipo,
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
c.anio_cobranza
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_empresas d,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo =d.e_codigo
and b.cod_sec_det = i.cod_sec_det
and a.e_codigo =b.e_codigo
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 1
and tipo_linea = 'RECLASIFICACIONES'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza =p_anio
group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
carga movimientos extraordinarios
****************************************************************************/
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
select  p_usuario,
x.des_empresa,
m.desmoneda,
a.refecliente,
sum(b.importe) as importe,
a.codfolio,
'Movimientos extraordinarios' as tipo,
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
c.anio_cobranza
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_calendario_cob d,
fecxc_monedas m,
fecxc_det_clasfecxc i,
fecxc_empresas x
where a.f_deposito != a.f_real_dep
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and a.e_codigo =x.e_codigo
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
group by m.desmoneda,x.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
carga cobranza virtual
****************************************************************************/
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
select p_usuario,
d.des_empresa,
m.desmoneda,
a.refecliente,
sum(b.importe) as importe,
a.codfolio,
'Cobranza Virtual' as tipo,
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
c.anio_cobranza
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_empresas d,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo =d.e_codigo
and b.cod_sec_det = i.cod_sec_det
and a.e_codigo =b.e_codigo
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 1
and tipo_linea = 'COBVIRTUAL'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza =p_anio
group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
carga otros ingresos
****************************************************************************/
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
select p_usuario,
d.des_empresa,
m.desmoneda,
coalesce(a.refecliente,''),
coalesce(sum(b.importe), 0) as totalderfe,
coalesce(a.codfolio,0),
'Otros conceptos' as tipo,
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
c.anio_cobranza
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_empresas d,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and a.e_codigo = d.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 2
and tipo_linea = 'OTROS'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza =p_anio
group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
if p_otros != 0 then
perform dbms_output.put_line(p_otros);
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
values (
p_usuario,
empresaloc,
monedaloc,
'',
p_otros,
'',
'Otros conceptos',
case p_mes
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
end,
p_anio
);
end if;
/****************************************************************************
carga intercambios
****************************************************************************/
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
select p_usuario,
d.des_empresa,
m.desmoneda,
coalesce(a.refecliente,''),
coalesce(sum(b.importe), 0) as totalderfe,
coalesce(a.codfolio,0),
'Intercambios' as tipo,
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
c.anio_cobranza
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_empresas d,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo = b.e_codigo
and a.e_codigo = d.e_codigo
and b.cod_sec_det = i.cod_sec_det
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 2
and tipo_linea = 'INTERCAMBIOS'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza =p_anio
group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
carga intereses
****************************************************************************/
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
select p_usuario,
d.des_empresa,
m.desmoneda,
a.refecliente,
sum(b.importe) as importe,
a.codfolio,
'Intereses' as tipo,
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
c.anio_cobranza
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_empresas d,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo =d.e_codigo
and b.cod_sec_det = i.cod_sec_det
and a.e_codigo =b.e_codigo
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 2
and tipo_linea = 'INTERESES'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza =p_anio
group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
carga dni
****************************************************************************/
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
select p_usuario,
d.des_empresa,
m.desmoneda,
a.refecliente,
sum(b.importe) as importe,
a.codfolio,
'DNI' as tipo,
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
c.anio_cobranza
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_calendario_cob c,
fecxc_empresas d,
fecxc_monedas m,
fecxc_det_clasfecxc i
where a.cod_sec_clasifica = b.cod_sec_clasifica
and a.e_codigo =d.e_codigo
and b.cod_sec_det = i.cod_sec_det
and a.e_codigo =b.e_codigo
and b.cod_sec_catclas = i.cod_sec_catclas
and a.f_deposito >= c.fecha_inicio
and a.f_deposito <= c.fecha_fin
and i.nopara_flujo = 2
and tipo_linea = 'DNI'
and a.secmoneda = m.secmoneda
and c.mes_cobranza = p_mes
and c.anio_cobranza =p_anio
group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
if p_dni != 0 then
perform dbms_output.put_line(p_dni);
insert into fecxc_conciliacion_det_rep(
usuario,
empresa,
moneda,
referencia,
importe,
folio,
tipo,
mes_rep,
anno_rep
)
values (
p_usuario,
empresaloc,
monedaloc,
'',
p_dni,
'',
'DNI',
case p_mes
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
end,
p_anio
);
end if;
/****************************************************************************
aplica formato
***************************************************************************
update  fecxc_conciliacion_det_rep set
importe = importe / p_formato
where usuario = p_usuario
and anno_rep = p_anio;*/
/****************************************************************************
fin
****************************************************************************/
end;
$body$
language plpgsql
;
