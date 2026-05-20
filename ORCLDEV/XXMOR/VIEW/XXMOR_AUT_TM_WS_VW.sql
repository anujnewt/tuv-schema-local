-- dmap_object_gen_tag : type : view name : xxmor_aut_tm_ws_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_aut_tm_ws_vw"  ("id_solicitud", "linea", "rtcrddscr", "rtcrd", "currcode", "buyuntid", "secnum", "stnid", "stnid_orig", "daychar", "duracion", "1a_transmision","airdate", "sobrecargo", "patron_trans", "fecha_inicio", "fecha_fin", "hora_inicio", "hora_fin", "advid", "mcontid", "marca", "accthdrid", "agencia", "fec_captura", "aux1", "aux2", "aux3", "aux4", "aux5") as select d.id_solicitud,
d.linea,
e.rtcrddscr,
e.rtcrd,
'0' as currcode,
d.buyuntid,
e.secnum,
case
when(select am.agrupador_multiple
from xxmor_cat_agrupador_mult_tab am
where am.agrupador_multiple = e.agrupador
and am.pivote = 'S') = e.agrupador
then (select am.prefijo_canal || oracle.substr(d.stnid, 3)
from xxmor_cat_agrupador_mult_tab am
where am.agrupador_multiple = e.agrupador
and am.pivote = 'S')
else
d.stnid
end
stnid,
d.stnid as stnid_orig,
'           ' as daychar,
d.duracion,
to_char(statement_timestamp(), 'YYYY-MM-DD') as "1a_transmision",
to_char(
to_timestamp(xxmor_funcional_pkg.
xxmor_sol_fechas_fun(d.id_solicitud, d.linea, 'F_1A_T'),'YYYYMMDD'),
'YYYY-MM-DD')
as airdate,
d.sobrecargo,
case d.sabado + d.domingo
when 0
then
lpad(lunes::text, 2, '0'::text)
|| lpad(martes::text, 2, '0'::text)
|| lpad(miercoles::text, 2, '0'::text)
|| lpad(jueves::text, 2, '0'::text)
|| lpad(viernes::text, 2, '0'::text)
--|| lpad (sabado, 2, '0')
--|| lpad (domingo, 2, '0')
else
lpad(' '::text, 10, ' '::text)
|| lpad(sabado::text, 2, '0'::text)
|| lpad(d.domingo::text, 2, '0'::text)
end
as patron_trans,
xxmor_funcional_pkg.
xxmor_fecha_sin_er_fun(d.fecha_inicio, 'AUT_TM')
as fecha_inicio,
xxmor_funcional_pkg_xxmor_fecha_sin_er_fun(d.fecha_fin, 'AUT_TM')
as fecha_fin,
d.hora_inicio || '0000' as hora_inicio,
d.hora_fin || '0000' as hora_fin,
e.advid,
e.mcontid,
d.marca,
e.accthdrid,
'              ' as agencia,
'              ' as fec_captura,
to_char(statement_timestamp(), 'YYYY-MM-DD') as aux1,
lpad(' '::text, 25, ' '::text) as aux2,
lpad(' '::text, 25, ' '::text) as aux3,
lpad(' '::text, 25, ' '::text) as aux4,
lpad(' '::text, 25, ' '::text) as "aux5"
from xxmor_solicitudes_det_tab d, xxmor_solicitudes_enc_tab e
where e.id_solicitud = d.id_solicitud and e.id_seg_neg = 1;/* dmap converted statement end */
-- estimed cost of view [ xxmor_aut_tm_ws_vw ]: 2.30;
