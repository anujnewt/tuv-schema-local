-- dmap_object_gen_tag : type : view name : xxmor_para_lin_vw
set search_path = xxmor,oracle,dmap_extension,public;
 /* dmap converted statement start */
create or replace view "xxmor_para_lin_vw"  ("id_solicitud", "linea", "p_ordid", "p_ordlnnum", "p_ordlnid", "p_stnid", "p_spotchr", "p_usrchr", "p_secnum", "p_strdt", "p_edt", "p_buyuntid", "p_strtim", "p_etim", "p_sptlen", "p_sptpat", "p_rt", "p_bkdt", "p_usrfl11", "p_lnsptord", "p_lnvalord", "p_prdid1", "p_brnd", "p_cmt", "p_mednum", "p_medcutnum", "p_dscr_rtadjust", "p_aux1", "p_aux2", "p_aux3", "p_usrfl19", "p_usrfl20") as select
e.id_solicitud,
d.linea,
(
select
er.estat_id_foraneo
from
xxmor_solicitudes_est_rep_tab er
where
er.id_solicitud = d.id_solicitud
and er.linea = 0
and er.id_sist = 1 )    p_ordid,
er.estat_id_foraneo      as p_ordlnnum,
er.aux2                     p_ordlnid,
d.stnid                  as p_stnid,
d.spot_chr               as p_spotchr,
case
when oracle.substr(e.mcontid, position('.' in e.mcontid) - 2, 2) in (
select
valor_parametro
from
xxmor.xxmor_conf_params_grls_tab
where
nombre_parametro = 'prefijo_usrchr' )
and nullif(trim(both from d.usr_chr::text), '') is null
then 'm'
when oracle.substr(e.mcontid, position('.' in e.mcontid) - 2, 2) in (
select
valor_parametro
from
xxmor.xxmor_conf_params_grls_tab
where
nombre_parametro = 'prefijo_usrchr' )
and nullif(trim(both from d.usr_chr::text), '') is not null
then trim(both d.usr_chr)
when oracle.substr(e.mcontid, position('.' in e.mcontid) - 2, 2) not in (
select
valor_parametro
from
xxmor.xxmor_conf_params_grls_tab
where
nombre_parametro = 'prefijo_usrchr' )
and nullif(trim(both from d.usr_chr::text), '') is not null
then trim(both d.usr_chr)
end as p_usrchr,
case
when coalesce(e.garantizado, 0) = 1
then '0'
when oracle.substr(e.comentarios, 1, 1) = '('
and oracle.substr(e.comentarios, 5, 1) = ')'
and oracle.substr(e.comentarios, 3, 1) = ','
then oracle.substr(e.comentarios, 2, 1)
when oracle.substr(e.mcontid, position('.' in e.mcontid) - 2, 2) in (
select
valor_parametro
from
xxmor.xxmor_conf_params_grls_tab
where
nombre_parametro = 'prefijo_usrchr' )
then '7'
else e.secnum
end                                                          as p_secnum,
to_char(to_timestamp(d.fecha_inicio,'yyyy-mm-dd'), 'yyyy-mm-dd') as p_strdt,
to_char(to_timestamp(d.fecha_fin,'yyyy-mm-dd'), 'yyyy-mm-dd')    as p_edt,
trim(both d.buyuntid)                                             as p_buyuntid,
d.hora_inicio||'0000'                                        as p_strtim,
d.hora_fin||'0000'                                           as p_etim,
abs(d.duracion)                                              as p_sptlen,
case when (d.lunes)::numeric =0 then  '  '  else lpad(d.lunes::text, 2, '0'::text) end || case when (d.martes::text)::numeric =0 then     '  '  else lpad(d.martes::text, 2, '0'::text) end || case when (d.miercoles::text)::numeric =0 then  '  '  else lpad(d.miercoles::text, 2, '0'::text) end || case when (d.jueves::text)::numeric =0 then  '  '  else lpad(d.jueves::text, 2, '0'::text) end || case when (d.viernes::text)::numeric =0 then  '  '  else lpad(d.viernes::text, 2, '0'::text) end || case when (d.sabado::text)::numeric =0 then  '  '  else lpad(d.sabado::text, 2, '0'::text) end || case when (d.domingo::text)::numeric =0 then  '  '  else lpad(d.domingo::text, 2, '0'::text) end  as
p_sptpat,
abs(trunc((d.tarifasp_sin_desc) * 100)) as p_rt,
to_char(statement_timestamp(), 'yyyy-mm-dd')          as p_bkdt,
case
when(
select
1
from
xxmor_concom_rpta_tab cr
where
cr.id_solicitud = d.id_solicitud
and cr.numlinea_concom = d.linea
and cr.accion_concom = 'autorizacion'
and cr.campo_concom in 'tarifa_manual'
and cr.estatus_orduni = 20 ) > 0
then 1
when(
select
count(1)
from
xxmor_cat_agrupador_mult_tab a
where
a.agrupador_multiple = e.agrupador
and a.agrupador_multiple = 'cabsky' ) > 0
and xxmor_funcional_pkg_xxmor_rtcrd_ca_fun(e.id_solicitud) > 0
then 1
else 0
end                                          as p_usrfl11,
d.spots                                      as p_lnsptord,
coalesce(round((d.tot_linea_sin_desc * 100)::numeric, 0), 0) as p_lnvalord,
oracle.substr(e.prdid_desc, 1, 4)                   as p_prdid1,
d.marca                                      as p_brnd,
d.observaciones                              as p_cmt,
d.bn                                         as p_mednum,
d.p                                          as p_medcutnum,
d.sobrecargo                                 as p_dscr_rtadjust,
(case when nullif(d.linea_hna::text, '') is not null then 1 else null end)                   as p_aux1,
oracle.substr(d.tipo_servicio,1,20)                 as p_aux2,
'      '                                     as p_aux3,
-- incio omw - cambio manejo de paquetes, 23-abr-2015
xxmor.xxmor_funcional_pkg_xxmor_valor_paquetes_fn( 'usrfl19', coalesce(upper(d.des_plataforma),
'sin valor') ) as p_usrfl19,
xxmor.xxmor_funcional_pkg_xxmor_valor_paquetes_fn( 'usrfl20', coalesce(upper(d.des_plataforma),
'sin valor') ) as p_usrfl20
-- fin omw - cambio manejo de paquetes, 23-abr-2015
from xxmor_fzas_vtas_tab f, xxmor_solicitudes_orig_enc_tab eo, xxmor_solicitudes_enc_tab e, (
select distinct
id_solicitud,
numlinea_concom
from
xxmor_concom_rpta_tab
where
nullif(numlinea_concom::text, '') is not null
except
select distinct
id_solicitud,
numlinea_concom
from
xxmor_concom_rpta_tab
where
estatus_orduni = '10' ) cr, xxmor_solicitudes_det_tab d
left outer join xxmor_solicitudes_est_rep_tab er on (d.id_solicitud = er.id_solicitud and d.linea = er.linea and 1 = er.id_sist)
where er.linea != 0 and nullif(er.estat_id_foraneo::text, '') is null and e.id_solicitud = d.id_solicitud and e.id_fza_ventas = f.id_fza_ventas and e.id_request = eo.id_request and d.id_solicitud = cr.id_solicitud and d.linea = cr.numlinea_concom   and nullif(er.aux2::text, '') is not null  and f.id_seg_neg = 1 and case
when xxmor_funcional_pkg_xxmor_es_sol_agr_mult_fun(e.id_solicitud) = 1 and division_montos = 1
then 1
when xxmor_funcional_pkg_xxmor_es_sol_agr_mult_fun(e.id_solicitud) = 0
then 1
else 0
end = 1 and e.id_solicitud =
(--para que no se inserten las lineas, cuyo encabezado no ha sido insertado
select
er.id_solicitud
from
xxmor_solicitudes_est_rep_tab er
where
er.id_solicitud = e.id_solicitud
and er.linea = 0
and nullif(er.estat_id_foraneo::text, '') is not null )  order by
d.id_solicitud,
(d.linea)::numeric  asc;
 /* dmap converted statement end */
-- estimed cost of view [ xxmor_para_lin_vw ]: 1.90;
